require 'fluent-icons'
require 'fluent-icons/scanner'
require 'fluent-icons/cache'

namespace :fluent_icons do
  desc "Scan your app for icon usage and generate a report"
  task :scan => :environment do
    puts "\n🔍 Scanning for Fluent Icons usage...\n\n"

    scanner = FluentIcons::Scanner.new(verbose: true)
    scanner.report
  end

  desc "Compile a minimal data.json with only used icons"
  task :compile => :environment do
    puts "\n⚙️  Compiling Fluent Icons for production...\n\n"

    scanner = FluentIcons::Scanner.new(verbose: ENV['VERBOSE'] == 'true')

    output_path = Rails.root.join('lib', 'build', 'data.compiled.json').to_s
    source_path = File.join(FluentIcons::ROOT_PATH, 'build', 'data.json')

    result = scanner.compile(
      output_path: output_path,
      source_data_path: source_path
    )

    puts "\n✅ Compilation complete! Your app will now use the compiled icon set in production."
    puts "\nTo use the compiled version:"
    puts "  • Production: Automatic (RAILS_ENV=production)"
    puts "  • Development/Test: Set FLUENT_ICONS_USE_COMPILED=true"
  rescue StandardError => e
    puts "\n❌ Compilation failed: #{e.message}"
    puts e.backtrace.first(5).join("\n") if ENV['VERBOSE'] == 'true'
    exit 1
  end

  desc "Clear the file-based icon cache"
  task :clear_cache do
    puts "\n🧹 Clearing Fluent Icons cache...\n"

    stats_before = FluentIcons::Cache.stats
    puts "Cache before: #{stats_before[:files]} files (#{stats_before[:size_human]})"

    FluentIcons::Cache.clear

    puts "✅ Cache cleared!\n"
  end

  desc "Show cache statistics"
  task :cache_stats do
    puts "\n📊 Fluent Icons Cache Statistics\n"
    puts "=" * 60

    stats = FluentIcons::Cache.stats
    puts "Location: #{stats[:directory]}"
    puts "Files: #{stats[:files]}"
    puts "Total size: #{stats[:size_human]}"
    puts "=" * 60 + "\n"
  end

  desc "Verify all icons in your app exist in data.json"
  task :verify => :environment do
    puts "\n✓ Verifying icon references...\n\n"

    scanner = FluentIcons::Scanner.new(verbose: false)
    icons = scanner.scan

    puts "Found #{icons.count} unique icons in #{scanner.files_scanned} files\n\n"

    # Load available icons
    data_path = File.join(FluentIcons::ROOT_PATH, 'build', 'data.json')
    available_icons = JSON.parse(File.read(data_path)).keys

    # Check for missing icons
    missing = icons - available_icons

    if missing.empty?
      puts "✅ All icons are valid!\n"
    else
      puts "❌ Found #{missing.count} invalid icon references:\n\n"
      missing.each { |icon| puts "  • #{icon}" }
      puts "\n"
      exit 1
    end
  end

  desc "Show gem statistics"
  task :stats do
    puts "\n📦 Fluent Icons Gem Statistics\n"
    puts "=" * 60

    # Count icons
    data_path = File.join(FluentIcons::ROOT_PATH, 'build', 'data.json')
    if File.exist?(data_path)
      data = JSON.parse(File.read(data_path))
      puts "Total icons available: #{data.keys.count}"
      puts "Data file size: #{human_size(File.size(data_path))}"
    end

    # Check for compiled version
    compiled_path = File.join(FluentIcons::ROOT_PATH, 'build', 'data.compiled.json')
    if File.exist?(compiled_path)
      compiled_data = JSON.parse(File.read(compiled_path))
      puts "\nCompiled version:"
      puts "  Icons: #{compiled_data.keys.count}"
      puts "  Size: #{human_size(File.size(compiled_path))}"
      reduction = ((1 - File.size(compiled_path).to_f / File.size(data_path)) * 100).round(2)
      puts "  Reduction: #{reduction}%"
    else
      puts "\nNo compiled version found. Run 'rake fluent_icons:compile' to create one."
    end

    # Cache stats
    cache_stats = FluentIcons::Cache.stats
    puts "\nCache:"
    puts "  Files: #{cache_stats[:files]}"
    puts "  Size: #{cache_stats[:size_human]}"

    puts "=" * 60 + "\n"
  end
end

def human_size(bytes)
  units = ['B', 'KB', 'MB', 'GB']
  return '0 B' if bytes == 0

  exp = (Math.log(bytes) / Math.log(1024)).floor
  exp = [exp, units.length - 1].min

  "%.2f %s" % [bytes.to_f / (1024 ** exp), units[exp]]
end
