module Fluent
  module Icons
    module FluentHelper
      def fluent(name, html_options = {})
        weight = html_options[:weight] || 20
        variation = html_options[:variation] || :regular

        asset = ['ic_fluent', name, weight, variation].join('_')
        path = [Rails.root, 'app/assets/images/fluent', asset].join('/')

        if (icon = (File.open("#{ path }.svg", 'r').read rescue nil)).nil?
          return Fluent::Icons::IconNotFoundError
        end

        doc = Nokogiri::HTML::DocumentFragment.parse(icon)
        svg = doc.at_css('svg')

        @_class = []
        @_class << 'fluent'
        @_class << html_options[:class] if html_options[:class].present?

        svg['class'] = @_class.join(' ')

        (html_options[:data] || {}).each { |key, value| svg["data-#{ key }"] = value }

        raw(doc)
      end
    
    private

      def html_safe()
      end
    end
  end
end