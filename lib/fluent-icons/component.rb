# frozen_string_literal: true

module FluentIcons
  # ViewComponent for rendering Fluent Icons
  #
  # Usage:
  #   <%= render FluentIcons::Component.new(name: "add") %>
  #   <%= render FluentIcons::Component.new(name: "delete", style: "filled", weight: 24) %>
  #   <%= render FluentIcons::Component.new(name: "search", class: "w-4 h-4 text-blue-500") %>
  #
  # With Hotwire/Turbo:
  #   <%= render FluentIcons::Component.new(name: "refresh", data: { action: "click->controller#refresh" }) %>
  class Component < ViewComponent::Base
    # @param name [String, Symbol] The icon name (e.g., "add", "delete", "search")
    # @param style [String] The icon style (default: "regular")
    # @param weight [Integer, String] The icon size/weight (default: 20)
    # @param options [Hash] Additional HTML attributes (class, id, data, aria, etc.)
    def initialize(name:, style: 'regular', weight: 20, **options)
      @name = name.to_s
      @style = style.to_s
      @weight = weight.to_i
      @options = options
    end

    def call
      # Use the existing caching system from the helper
      svg_html = Cache.fetch(@name, cache_options) do
        icon = FluentIcons::Fluent.new(@name, style: @style, weight: @weight, **@options)
        icon.to_svg
      end

      svg_html.html_safe
    end

    private

    def cache_options
      {
        style: @style,
        weight: @weight,
        class: @options[:class],
        id: @options[:id]
      }.compact
    end
  end
end
