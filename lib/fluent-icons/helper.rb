require 'fluent-icons'
require 'action_view'

module FluentIcons
  include ActionView::Helpers::TagHelper

  mattr_accessor :fluent_helper_cache, default: {}

  def fluent(symbol, options = {})
    return '' if symbol.nil?

    cache_key = [symbol, options]

    unless (tag = fluent_helper_cache[cache_key])
      icon = FluentIcons::Fluent.new(symbol, options)
      fluent_helper_cache[cache_key] = icon.to_svg
    end

    tag&.html_safe
  end
  alias :fluent_icon :fluent 
end