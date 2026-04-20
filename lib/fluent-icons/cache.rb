require 'fileutils'
require 'json'
require 'digest'
require 'tmpdir'

module FluentIcons
  class Cache
    class << self
      # Cache directory in Rails tmp or system tmp
      def cache_dir
        @cache_dir ||= begin
          dir = if defined?(Rails)
            Rails.root.join('tmp', 'cache', 'fluent-icons')
          else
            File.join(Dir.tmpdir, 'fluent-icons-cache')
          end
          FileUtils.mkdir_p(dir)
          dir.to_s
        end
      end

      # Generate cache key from symbol and options
      def cache_key(symbol, options = {})
        normalized_options = options.sort.to_h
        content = "#{symbol}:#{normalized_options.inspect}"
        Digest::MD5.hexdigest(content)
      end

      # Read from file cache
      def read(key)
        file_path = File.join(cache_dir, "#{key}.html")
        return nil unless File.exist?(file_path)

        # Check if cache is stale (older than 1 hour)
        if File.mtime(file_path) < Time.now - 3600
          File.delete(file_path)
          return nil
        end

        File.read(file_path)
      rescue StandardError => e
        # Silently fail and regenerate
        nil
      end

      # Write to file cache
      def write(key, content)
        file_path = File.join(cache_dir, "#{key}.html")
        File.write(file_path, content)
      rescue StandardError => e
        # Silently fail - caching is optional
        nil
      end

      # Fetch from cache or generate
      def fetch(symbol, options = {})
        key = cache_key(symbol, options)
        cached = read(key)

        return cached if cached

        # Generate new content
        content = yield if block_given?
        write(key, content) if content
        content
      end

      # Clear all cached files
      def clear
        return unless Dir.exist?(cache_dir)

        FileUtils.rm_rf(Dir.glob(File.join(cache_dir, '*.html')))
      end

      # Get cache statistics
      def stats
        return { size: 0, files: 0 } unless Dir.exist?(cache_dir)

        files = Dir.glob(File.join(cache_dir, '*.html'))
        size = files.sum { |f| File.size(f) }

        {
          files: files.count,
          size: size,
          size_human: human_size(size),
          directory: cache_dir
        }
      end

      private

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
