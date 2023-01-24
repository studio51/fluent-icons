require 'fluent-icons'
require 'action_view'

module FluentIcons
  include ActionView::Helpers::TagHelper

  mattr_accessor :fluent_helper_cache, default: {}

  def fluent(symbol, options = {}, fallback_text = 'Error?')
    # return symbol.class.name if symbol.nil? || !symbol.is_a?(String) || !symbol.is_a?(Symbol)

    cache_key = [symbol, options]
    tag = fluent_helper_cache.dig(*cache_key)

    unless tag
      icon = FluentIcons::Fluent.new(symbol, options)
      tag = icon.to_svg
      fluent_helper_cache[cache_key] = tag
    end

    tag.html_safe
  end
  alias :fluent_icon :fluent

  def clear_fluent_helper_cache
    fluent_helper_cache.clear
  end
end