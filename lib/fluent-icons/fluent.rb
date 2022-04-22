module FluentIcons
  class Fluent
    attr_reader :path, :options, :width, :height, :symbol, :keywords, :weight, :style, :prefix

    def initialize(symbol, options = {})
      @symbol = symbol.to_s

      @style  = (options.delete(:style) || 'regular').to_s
      @weight = (options.delete(:weight) || 20).to_s
      @prefix = (options.delete(:prefix) || 'fluent').to_s

      if (fluent = get_fluent_path(@symbol, style, weight))[:path].nil?
        @path = "<path d=\"M7 4.5C7 4.67123 6.98278 4.83844 6.94999 5H10C10.5523 5 11 5.44772 11 6V8H10C9.49278 8 9.02965 8.18882 8.67709 8.5C8.61444 8.55529 8.55529 8.61444 8.5 8.67709C8.18882 9.02965 8 9.49278 8 10V11H6C5.44772 11 5 10.5523 5 10V6.94999C4.83844 6.98278 4.67123 7 4.5 7C4.32877 7 4.16155 6.98278 4 6.94999V10C4 11.1046 4.89543 12 6 12H8V14C8 14.5072 8.18882 14.9703 8.5 15.3229C8.68196 15.5291 8.90577 15.6974 9.15812 15.8147C9.0548 15.3934 9 14.9531 9 14.5C9 14.3821 9.00371 14.265 9.01102 14.149C9.00376 14.1004 9 14.0506 9 14V10C9 9.44772 9.44772 9 10 9H14C14.0506 9 14.1004 9.00376 14.149 9.01102C14.265 9.00371 14.3821 9 14.5 9C14.9531 9 15.3934 9.0548 15.8147 9.15812C15.6974 8.90577 15.5291 8.68196 15.3229 8.5C14.9703 8.18882 14.5072 8 14 8H12V6C12 4.89543 11.1046 4 10 4H6.94999C6.98278 4.16155 7 4.32877 7 4.5ZM6 4.5C6 5.32843 5.32843 6 4.5 6C3.67157 6 3 5.32843 3 4.5C3 3.67157 3.67157 3 4.5 3C5.32843 3 6 3.67157 6 4.5ZM17 4.5C17 5.32843 16.3284 6 15.5 6C14.6716 6 14 5.32843 14 4.5C14 3.67157 14.6716 3 15.5 3C16.3284 3 17 3.67157 17 4.5ZM6 15.5C6 16.3284 5.32843 17 4.5 17C3.67157 17 3 16.3284 3 15.5C3 14.6716 3.67157 14 4.5 14C5.32843 14 6 14.6716 6 15.5ZM19 14.5C19 16.9853 16.9853 19 14.5 19C12.0147 19 10 16.9853 10 14.5C10 12.0147 12.0147 10 14.5 10C16.9853 10 19 12.0147 19 14.5ZM16.3536 13.3536C16.5488 13.1583 16.5488 12.8417 16.3536 12.6464C16.1583 12.4512 15.8417 12.4512 15.6464 12.6464L14.5 13.7929L13.3536 12.6464C13.1583 12.4512 12.8417 12.4512 12.6464 12.6464C12.4512 12.8417 12.4512 13.1583 12.6464 13.3536L13.7929 14.5L12.6464 15.6464C12.4512 15.8417 12.4512 16.1583 12.6464 16.3536C12.8417 16.5488 13.1583 16.5488 13.3536 16.3536L14.5 15.2071L15.6464 16.3536C15.8417 16.5488 16.1583 16.5488 16.3536 16.3536C16.5488 16.1583 16.5488 15.8417 16.3536 15.6464L15.2071 14.5L16.3536 13.3536Z\" fill=\"currentColor\" />"
      else
        @path = fluent[:path]
      end

      @width   = (options[:width] || weight).to_i
      @height  = (options[:height] || weight).to_i
      @options = options.dup
      
      @options.merge!({
        class:   classes,
        viewBox: [0, 0, width, height].join(' ').to_s,
        version: '1.1'
      })

      @options.merge!(a11y)
    end

    def to_svg
      "<svg fill=\"none\" width=\"#{ width }\" height=\"#{ height }\" #{ html_attributes } xmlns=\"http://www.w3.org/2000/svg\">#{ @path }</svg>".strip
    end

  private

    def html_attributes
      attrs = ''

      options.each { |attr, value| attrs += "#{ attr }=\"#{ value }\" " }
      
      attrs.strip
    end

    def classes
      "#{ prefix } #{ prefix }-#{ symbol } #{ options[:class] } ".strip
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

    def get_fluent_path(symbol, style, weight)
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
