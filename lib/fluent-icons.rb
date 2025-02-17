require 'json'
require 'fluent-icons/version'
require 'fluent-icons/fluent'

if defined?(Rails)
  require 'fluent-icons/helper'
  require 'fluent-icons/railtie'
end
module FluentIcons
  # Load data lazily
  def self.symbols
    @symbols ||= begin
                   data = File.read(
                     File.join(File.dirname(__FILE__), "./build/data.json")
                   )
                   JSON.parse(data).freeze
                 end
  end

  def self.const_missing(name)
    if name == :SYMBOLS
      symbols
    else
      super
    end
  end

  if ENV['FLUENT_ICONS_BENCHMARK']
    require 'benchmark'
    def fluent_with_benchmark(*)
      result = nil
      time = Benchmark.measure { result = super }
      Rails.logger.debug("FluentIcons generation took: #{time.real}s")
      result
    end
    alias_method :fluent_without_benchmark, :fluent
    alias_method :fluent, :fluent_with_benchmark
  end
end
