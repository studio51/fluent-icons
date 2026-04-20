# Configuration Guide

FluentIcons can be configured via an initializer file.

## Generating Configuration

```bash
rails generate fluent_icons:install
```

This creates `config/initializers/fluent_icons.rb` with all available options.

## Configuration Options

### `use_view_component`

**Type:** Boolean
**Default:** `false`

Enable ViewComponent integration for the `fluent()` helper.

When enabled:
- The `fluent()` helper uses `FluentIcons::Component` internally
- Better testability through ViewComponent testing patterns
- Better compatibility with Rails 7.1+
- No changes needed in your views

**Requirements:**
- `view_component` gem must be installed

**Example:**

```ruby
# config/initializers/fluent_icons.rb

FluentIcons.configure do |config|
  # Enable ViewComponent integration
  config.use_view_component = true
end
```

**Usage in views (same with or without ViewComponent):**

```erb
<%= fluent('add', style: 'filled', weight: 24) %>
<%= fluent('delete', class: 'w-6 h-6 text-red-500') %>
```

## Environment-Specific Configuration

You can configure FluentIcons differently per environment:

```ruby
# config/initializers/fluent_icons.rb

FluentIcons.configure do |config|
  # Use ViewComponent in production for better performance
  config.use_view_component = Rails.env.production?

  # Or enable only in specific environments
  config.use_view_component = %w[production staging].include?(Rails.env)
end
```

## Programmatic Configuration

You can also configure FluentIcons programmatically anywhere in your app:

```ruby
# In a Rails initializer, test helper, etc.

FluentIcons.configure do |config|
  config.use_view_component = true
end

# Or access the configuration directly
FluentIcons.configuration.use_view_component = true

# Reset to defaults
FluentIcons.reset_configuration!
```

## Troubleshooting

### ViewComponent not being used

If you've enabled `use_view_component = true` but icons are still rendered without ViewComponent:

1. **Check that ViewComponent is installed:**
   ```bash
   bundle show view_component
   ```

2. **Restart your Rails server** after changing configuration

3. **Check for errors** in your Rails logs

4. **Verify the configuration is loaded:**
   ```ruby
   # In Rails console
   FluentIcons.configuration.use_view_component
   # Should return: true
   ```

### Configuration not loaded

If your configuration isn't being applied:

1. **Check file location:** Should be at `config/initializers/fluent_icons.rb`
2. **Check syntax:** Make sure there are no Ruby syntax errors
3. **Restart Rails:** Configuration is loaded once at startup

## More Information

- [Main README](./README.md)
- [ViewComponent Documentation](./VIEW_COMPONENT.md)
- [Icon Showcase](./showcase.html)
