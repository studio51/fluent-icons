require 'set'
require 'json'

module FluentIcons
  class Scanner
    attr_reader :icons_found, :files_scanned

    def initialize(paths: default_paths, verbose: false)
      @paths = Array(paths)
      @icons_found = Set.new
      @files_scanned = 0
      @verbose = verbose
    end

    # Scan all files and return found icons
    def scan
      @icons_found.clear
      @files_scanned = 0

      @paths.each do |path|
        if Dir.exist?(path)
          scan_directory(path)
        elsif File.exist?(path)
          scan_file(path)
        else
          warn "[FluentIcons::Scanner] Path not found: #{path}" if @verbose
        end
      end

      @icons_found.to_a.sort
    end

    # Generate compiled data.json with only used icons
    def compile(output_path:, source_data_path: nil)
      icons = scan

      if icons.empty?
        warn "[FluentIcons::Scanner] No icons found. Compiled file will be empty."
      else
        puts "[FluentIcons::Scanner] Found #{icons.count} unique icons in #{@files_scanned} files"
      end

      # Load full data.json
      source_data_path ||= File.join(File.dirname(__FILE__), '..', 'build', 'data.json')

      unless File.exist?(source_data_path)
        raise "[FluentIcons::Scanner] Source data file not found: #{source_data_path}"
      end

      full_data = JSON.parse(File.read(source_data_path))

      # Filter to only used icons
      compiled_data = {}
      icons.each do |icon|
        if full_data[icon]
          compiled_data[icon] = full_data[icon]
        else
          warn "[FluentIcons::Scanner] Warning: Icon '#{icon}' not found in data.json" if @verbose
        end
      end

      # Write compiled data
      File.write(output_path, JSON.pretty_generate(compiled_data))

      original_size = File.size(source_data_path)
      compiled_size = File.size(output_path)
      reduction_pct = ((1 - compiled_size.to_f / original_size) * 100).round(2)

      puts "[FluentIcons::Scanner] Compilation complete!"
      puts "  Original size: #{human_size(original_size)}"
      puts "  Compiled size: #{human_size(compiled_size)}"
      puts "  Reduction: #{reduction_pct}%"
      puts "  Output: #{output_path}"

      {
        icons_count: compiled_data.keys.count,
        original_size: original_size,
        compiled_size: compiled_size,
        reduction_percent: reduction_pct,
        output_path: output_path
      }
    end

    # Generate report of icon usage
    def report
      icons = scan

      puts "\n" + "=" * 60
      puts "FluentIcons Usage Report"
      puts "=" * 60
      puts "Files scanned: #{@files_scanned}"
      puts "Unique icons found: #{icons.count}"
      puts "=" * 60
      puts "\nIcons:"
      icons.each { |icon| puts "  - #{icon}" }
      puts "=" * 60 + "\n"
    end

    private

    def default_paths
      if defined?(Rails)
        [
          Rails.root.join('app', 'views'),
          Rails.root.join('app', 'helpers'),
          Rails.root.join('app', 'components'),
          Rails.root.join('app', 'javascript'),
          Rails.root.join('app', 'frontend')
        ].map(&:to_s).select { |p| Dir.exist?(p) }
      else
        ['app/views', 'app/helpers', 'app/components'].select { |p| Dir.exist?(p) }
      end
    end

    def scan_directory(dir)
      patterns = ['**/*.erb', '**/*.slim', '**/*.tsx', '**/*.ts', '**/*.jsx', '**/*.js', '**/*.rb']

      patterns.each do |pattern|
        Dir.glob(File.join(dir, pattern)).each do |file|
          scan_file(file)
        end
      end
    end

    def scan_file(file_path)
      return unless File.file?(file_path)

      content = File.read(file_path)
      @files_scanned += 1

      # Find all fluent() or fluent_icon() calls
      icons = extract_icons(content)

      if icons.any? && @verbose
        puts "[FluentIcons::Scanner] Found #{icons.count} icons in #{file_path}"
      end

      @icons_found.merge(icons)
    rescue StandardError => e
      warn "[FluentIcons::Scanner] Error scanning #{file_path}: #{e.message}" if @verbose
    end

    def extract_icons(content)
      icons = Set.new

      # Pattern 1: fluent('icon_name') or fluent("icon_name")
      # Pattern 2: fluent_icon('icon_name') or fluent_icon("icon_name")
      # Pattern 3: fluent(:icon_name) or fluent_icon(:icon_name)
      patterns = [
        /fluent(?:_icon)?\s*\(\s*['"]([a-z0-9_]+)['"]/i,  # String literals
        /fluent(?:_icon)?\s*\(\s*:([a-z0-9_]+)/i           # Symbol literals
      ]

      patterns.each do |pattern|
        content.scan(pattern) do |match|
          icon_name = match[0].strip
          icons.add(icon_name) unless icon_name.empty?
        end
      end

      # For TypeScript/JavaScript files, also look for FluentIcons usage
      # Example: FluentIcons.Fluent.new('icon_name', ...)
      if content =~ /FluentIcons|fluent-icons/
        content.scan(/(?:FluentIcons|Fluent)\.new\s*\(\s*['"]([a-z0-9_]+)['"]/i) do |match|
          icons.add(match[0].strip)
        end
      end

      icons
    end

    def human_size(bytes)
      units = ['B', 'KB', 'MB', 'GB']
      return '0 B' if bytes == 0

      exp = (Math.log(bytes) / Math.log(1024)).floor
      exp = [exp, units.length - 1].min

      "%.2f %s" % [bytes.to_f / (1024 ** exp), units[exp]]
    end
  end
end
