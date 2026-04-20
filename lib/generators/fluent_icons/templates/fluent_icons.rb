# FluentIcons Configuration
#
# Configure how FluentIcons renders icons in your Rails application.
# For more information, see: https://github.com/studio51/fluent-icons

FluentIcons.configure do |config|
  # Use ViewComponent for rendering icons (requires view_component gem)
  #
  # When enabled, the fluent() helper will use FluentIcons::Component internally.
  # This provides better testability and follows ViewComponent patterns.
  #
  # Default: false
  # config.use_view_component = false

  # To enable ViewComponent integration:
  # 1. Add to your Gemfile: gem 'view_component'
  # 2. Run: bundle install
  # 3. Uncomment the line below:
  # config.use_view_component = true
end
