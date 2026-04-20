# frozen_string_literal: true

require 'rails/generators/base'

module FluentIcons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Creates FluentIcons initializer for your application'

      def copy_initializer
        template 'fluent_icons.rb', 'config/initializers/fluent_icons.rb'

        puts
        puts '=' * 60
        puts 'FluentIcons configuration file created!'
        puts '=' * 60
        puts
        puts 'Configuration file: config/initializers/fluent_icons.rb'
        puts
        puts 'To enable ViewComponent integration, edit the file and set:'
        puts '  config.use_view_component = true'
        puts
        puts '=' * 60
      end
    end
  end
end
