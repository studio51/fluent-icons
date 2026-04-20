require 'json'
require 'fluent-icons/version'
require 'fluent-icons/fluent'
require 'fluent-icons/lazy_loader'
require 'fluent-icons/cache'

if defined?(Rails)
  require 'fluent-icons/helper'
  require 'fluent-icons/railtie'

  # Load ViewComponent integration if ViewComponent is available
  if defined?(ViewComponent::Base)
    require 'fluent-icons/component'
  end
end

module FluentIcons
  # Root path for the gem (used by rake tasks)
  ROOT_PATH = File.dirname(__FILE__)

  # Lazy-loaded symbols (supports compiled data.json in production)
  def self.symbols
    LazyLoader.symbols
  end

  # For backwards compatibility
  SYMBOLS = LazyLoader.symbols.freeze
end