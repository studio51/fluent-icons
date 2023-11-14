require 'json'
require 'fluent-icons/version'
require 'fluent-icons/fluent'
require 'fluent-icons/cache'

if defined?(Rails)
  require 'fluent-icons/helper'
  require 'fluent-icons/railtie'
end

module FluentIcons
  data = File.read(
    File.join(
      File.dirname(__FILE__), "./build/data.json"
    )
  )
  
  SYMBOLS = JSON.parse(data).freeze
end