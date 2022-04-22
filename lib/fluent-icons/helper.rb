require 'fluent-icons'
require 'action_view'

module FluentIcons
  include ActionView::Helpers::TagHelper

  mattr_accessor :fluent_helper_cache, default: {}

  def fluent(symbol, options = {})
    return '' if symbol.nil?

    cache_key = [symbol, options]

    unless (tag = fluent_helper_cache[cache_key])
      fluent_helper_cache[cache_key] = FluentIcons::Fluent.new(symbol, options).to_svg
    end

    tag
  end
  alias_method :fluent_icon, :fluent 
end