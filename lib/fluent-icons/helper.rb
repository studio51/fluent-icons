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

      tag = content_tag(:svg, icon.path.html_safe, icon.options).freeze # rubocop:disable Rails/OutputSafety
      fluent_helper_cache[cache_key] = tag
    end

    tag
  end
end