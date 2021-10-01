require 'fluent/icons/version'
require 'fluent/icons/engine' if defined?(::Rails)

module Fluent
  module Icons
    isolate_namespace Fluent::Icons

    class Error < StandardError; end
    class IconNotFoundError < StandardError; end
  end
end