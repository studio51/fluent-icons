# frozen_string_literal: true

module FluentIcons
  class Configuration
    # @return [Boolean] Whether to use ViewComponent for rendering icons (default: false)
    attr_accessor :use_view_component

    def initialize
      @use_view_component = false
    end
  end

  class << self
    # @return [FluentIcons::Configuration] The current configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Configure FluentIcons
    #
    # @example
    #   FluentIcons.configure do |config|
    #     config.use_view_component = true
    #   end
    #
    # @yield [configuration] The configuration object
    def configure
      yield(configuration)
    end

    # Reset configuration to defaults
    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end
