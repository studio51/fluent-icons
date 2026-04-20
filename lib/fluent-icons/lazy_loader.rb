require 'json'

module FluentIcons
  class LazyLoader
    class << self
      # Initialize with lazy loading support
      def symbols
        @symbols ||= load_symbols
      end

      # Reset symbols (useful for testing or reloading)
      def reset!
        @symbols = nil
        @data_file_path = nil
      end

      private

      def load_symbols
        # Check for compiled data.json first (production optimization)
        compiled_path = File.join(build_dir, 'data.compiled.json')
        full_path = File.join(build_dir, 'data.json')

        # Use compiled version if it exists and we're in production
        if use_compiled? && File.exist?(compiled_path)
          load_json_file(compiled_path, compiled: true)
        elsif File.exist?(full_path)
          load_json_file(full_path, compiled: false)
        else
          warn "[FluentIcons] Warning: No icon data file found at #{full_path}"
          {}
        end
      end

      def load_json_file(path, compiled: false)
        data = JSON.parse(File.read(path))

        if compiled
          puts "[FluentIcons] Loaded #{data.keys.count} compiled icons from #{File.basename(path)} (#{human_size(File.size(path))})"
        else
          puts "[FluentIcons] Loaded #{data.keys.count} icons from #{File.basename(path)} (#{human_size(File.size(path))})"
        end

        data.freeze
      rescue JSON::ParserError => e
        warn "[FluentIcons] Error parsing #{path}: #{e.message}"
        {}
      rescue StandardError => e
        warn "[FluentIcons] Error loading #{path}: #{e.message}"
        {}
      end

      def build_dir
        File.join(File.dirname(__FILE__), '..', 'build')
      end

      def use_compiled?
        # Use compiled version if:
        # 1. RAILS_ENV is production, or
        # 2. FLUENT_ICONS_USE_COMPILED environment variable is set
        (defined?(Rails) && Rails.env.production?) ||
          ENV['FLUENT_ICONS_USE_COMPILED'] == 'true'
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
end
