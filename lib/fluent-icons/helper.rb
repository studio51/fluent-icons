module FluentIcons
  include ActionView::Helpers::TagHelper

  # Use a more efficient cache structure
  mattr_accessor :fluent_helper_cache, default: Concurrent::Map.new

  def fluent(symbol, options = {}, fallback_text = 'Error?')
    cache_key = "#{symbol}:#{options.hash}"

    fluent_helper_cache.fetch(cache_key) do
      icon = FluentIcons::Fluent.new(symbol, options)
      tag = icon.to_svg
      fluent_helper_cache[cache_key] = tag.html_safe
    end
  end
end
