require 'fluent-icons'
require 'action_view'

module FluentIcons
  include ActionView::Helpers::TagHelper

  # In-memory cache (first layer - fastest)
  mattr_accessor :fluent_helper_cache, default: {}

  def fluent(symbol, options = {}, fallback_text = 'Error?')
    # Normalize symbol to string
    symbol = symbol.to_s if symbol.is_a?(Symbol)

    # If ViewComponent is enabled via configuration, use the component
    if FluentIcons.configuration.use_view_component && defined?(FluentIcons::Component)
      # Extract style and weight from options
      style = options.delete(:style) || 'regular'
      weight = options.delete(:weight) || 20

      # Render the component
      component = FluentIcons::Component.new(
        name: symbol,
        style: style,
        weight: weight,
        **options
      )

      return component.render_in(self)
    end

    # Fallback to direct SVG rendering
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