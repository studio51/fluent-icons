require 'fluent/icons/version'
require 'fluent/icons/engine' if defined?(::Rails)

module Fluent
  module Icons
    class Error < StandardError; end
    class Error < IconNotFoundError; end
  end
end