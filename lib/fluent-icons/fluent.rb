module FluentIcons
  class Fluent
    attr_reader :path, :options, :width, :height, :symbol, :keywords, :weight, :style, :prefix

    def initialize(symbol, options = {})
      @symbol = symbol.to_s
      @style  = (options[:style] || 'regular').to_s
      @weight = (options[:weight] || 20).to_s
      @prefix = (options[:prefix] || 'fluent').to_s

      if (fluent = get_fluent_path(@symbol, style, weight, options))
        @path       = fluent[:path]
        @width      = fluent[:width] || 20
        @height     = fluent[:height] || 20
        @keywords   = fluent[:keywords] || []
        @options    = options.dup
        
        @options.merge!({
          class:   classes,
          viewBox: viewbox,
          version: '1.1'
        })

        @options.merge!(a11y)
      else
        raise "Couldn't find octicon symbol for #{ @symbol.inspect }"
      end
    end

    def to_svg
      "<svg #{ html_attributes }>#{ @path }</svg>".strip
    end

    private

    def html_attributes
      attrs = ''
      options.each { |attr, value| attrs += "#{ attr }='#{ value }' " }
      attrs.strip
    end

    def a11y
      accessible = { }

      if options['aria-label'].nil?
        accessible['aria-hidden'] = true
      else
        accessible['role'] = 'img'
      end

      accessible
    end

    def classes
      "#{ prefix } #{ prefix }-#{ symbol } #{ options[:class] } ".strip
    end

    def viewbox
      [0, 0, width, height].join(' ').to_s
    end

    def get_fluent_path(symbol, style, weight, options = {})
      if (icon = FluentIcons::SYMBOLS[symbol])

        return {
          name:     icon['name'],
          keywords: [],
          path:     icon.dig('icons', style, weight)
        }
      end
    end
  end
end
