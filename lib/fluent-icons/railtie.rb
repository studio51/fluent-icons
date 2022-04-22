require 'rails'

module FluentIcons
  class Railtie < Rails::Railtie
    initializer 'fluent-icons.helper' do
      ActionView::Base.send(:include, FluentIcons)
    end
  end
end