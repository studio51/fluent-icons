require 'fluent-icons'
require 'action_view'

module FluentIcons
  include ActionView::Helpers::TagHelper

  # In-memory cache (first layer - fastest)
  mattr_accessor :fluent_helper_cache, default: {}

  def fluent(symbol, options = {}, fallback_text = 'Error?')
    # Normalize symbol to string
    symbol = symbol.to_s if symbol.is_a?(Symbol)

    # Layer 1: In-memory cache (fastest)
    cache_key = [symbol, options]
    tag = fluent_helper_cache.dig(*cache_key)
    return tag.html_safe if tag

    # Layer 2: File-based cache (persistent)
    tag = Cache.fetch(symbol, options) do
      icon = FluentIcons::Fluent.new(symbol, options)
      icon.to_svg
    end

    # Store in memory cache for this request
    fluent_helper_cache[cache_key] = tag if tag

    tag.html_safe
  end
  alias :fluent_icon :fluent

  def clear_fluent_helper_cache
    fluent_helper_cache.clear
    Cache.clear
  end
end