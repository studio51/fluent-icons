# ViewComponent Support

FluentIcons now supports [ViewComponent](https://viewcomponent.org/) for a more modern, testable approach to rendering icons in Rails applications.

## Easy Opt-In Setup 🎉

ViewComponent integration is opt-in via configuration. Once enabled, the `fluent()` helper uses ViewComponent internally - no code changes needed!

### Step-by-Step Setup

1. **Add ViewComponent to your Gemfile:**
```ruby
gem 'view_component'
gem 'fluent-icons'
```

2. **Install the gems:**
```bash
bundle install
```

3. **Generate the configuration file:**
```bash
rails generate fluent_icons:install
```

4. **Enable ViewComponent in `config/initializers/fluent_icons.rb`:**
```ruby
FluentIcons.configure do |config|
  config.use_view_component = true
end
```

5. **Restart your Rails server**

That's it! Your existing `fluent()` helper calls will now use ViewComponent.

## Automatic Integration

### Before (without ViewComponent):
```erb
<%= fluent('add', style: 'filled', class: 'icon') %>
<!-- Renders SVG directly -->
```

### After (with ViewComponent):
```erb
<%= fluent('add', style: 'filled', class: 'icon') %>
<!-- Same code, now uses ViewComponent internally! -->
```

## Usage

### Basic Usage

```erb
<%= render FluentIcons::Component.new(name: "add") %>
```

### With Custom Style

```erb
<%= render FluentIcons::Component.new(
  name: "heart",
  style: "filled"
) %>
```

### With Custom Size

```erb
<%= render FluentIcons::Component.new(
  name: "search",
  weight: 24
) %>
```

### With Tailwind CSS Classes

```erb
<%= render FluentIcons::Component.new(
  name: "delete",
  style: "filled",
  weight: 20,
  class: "w-5 h-5 text-red-500 hover:text-red-700"
) %>
```

### With Accessibility (ARIA)

```erb
<%= render FluentIcons::Component.new(
  name: "close",
  aria: { label: "Close dialog" }
) %>
```

### With Hotwire/Turbo

```erb
<%= render FluentIcons::Component.new(
  name: "refresh",
  data: {
    action: "click->refresh#reload",
    turbo_frame: "content"
  }
) %>
```

## Complete Examples

### Button with Icon

```erb
<button class="btn btn-primary">
  <%= render FluentIcons::Component.new(
    name: "add",
    class: "w-4 h-4 mr-2"
  ) %>
  Add Item
</button>
```

### Navigation Menu

```erb
<nav class="flex gap-4">
  <a href="/home" class="flex items-center gap-2">
    <%= render FluentIcons::Component.new(name: "home", class: "w-5 h-5") %>
    Home
  </a>
  <a href="/search" class="flex items-center gap-2">
    <%= render FluentIcons::Component.new(name: "search", class: "w-5 h-5") %>
    Search
  </a>
  <a href="/profile" class="flex items-center gap-2">
    <%= render FluentIcons::Component.new(name: "person", class: "w-5 h-5") %>
    Profile
  </a>
</nav>
```

### Alert with Icon

```erb
<div class="alert alert-warning">
  <%= render FluentIcons::Component.new(
    name: "warning",
    style: "filled",
    class: "w-5 h-5 text-yellow-600 inline-block mr-2"
  ) %>
  Please review your settings
</div>
```

### Loading Spinner

```erb
<div class="flex items-center gap-2">
  <%= render FluentIcons::Component.new(
    name: "arrow_sync",
    class: "w-5 h-5 animate-spin text-blue-500"
  ) %>
  Loading...
</div>
```

## API Reference

### Parameters

- `name` (required): The icon name as a string or symbol (e.g., "add", :delete)
- `style` (optional): The icon style - "regular" or "filled" (default: "regular")
- `weight` (optional): The icon size - 16, 20, 24, 28, or 32 (default: 20)
- `**options`: Any additional HTML attributes (class, id, data, aria, etc.)

### Available Icons

Browse all 2,998 available icons at the [Icon Showcase](./showcase.html) or visit [fluenticons.co](https://fluenticons.co/)

## Performance

The ViewComponent uses the same optimized caching system as the helper method:

- **In-memory caching**: Fast per-request caching
- **File-based caching**: Persistent cache stored in `tmp/cache/fluent-icons/`
- **Production compilation**: Use `rake fluent_icons:compile` to reduce icon data from 22MB to <100KB

## Helper vs Direct Component Rendering

### Option 1: Use the Helper (Recommended)
```erb
<%= fluent('add', style: 'filled', weight: 24, class: 'icon') %>
<!-- Automatically uses ViewComponent if installed -->
```

### Option 2: Render Component Directly (Advanced)
```erb
<%= render FluentIcons::Component.new(
  name: 'add',
  style: 'filled',
  weight: 24,
  class: 'icon'
) %>
<!-- Explicit ViewComponent rendering -->
```

**We recommend using the helper (`fluent()`) because:**
- ✅ Cleaner, shorter syntax
- ✅ Works with or without ViewComponent
- ✅ Automatically switches to ViewComponent when available
- ✅ Zero migration needed for existing code
- ✅ Same performance as direct component rendering

**Direct component rendering is useful when:**
- 🔧 You want explicit ViewComponent syntax
- 🔧 Building custom wrapper components
- 🔧 Need advanced ViewComponent features

Both methods use the same underlying caching system!

## Testing

You can test ViewComponents using standard ViewComponent testing patterns:

```ruby
require "test_helper"

class FluentIcons::ComponentTest < ViewComponent::TestCase
  def test_renders_icon
    render_inline(FluentIcons::Component.new(name: "add"))

    assert_selector "svg"
  end

  def test_renders_with_custom_class
    render_inline(FluentIcons::Component.new(
      name: "add",
      class: "custom-class"
    ))

    assert_selector "svg.custom-class"
  end
end
```

## Troubleshooting

### Component not found

If you get an error about `FluentIcons::Component` not being defined:

1. Make sure ViewComponent is installed: `bundle show view_component`
2. Restart your Rails server
3. Check that ViewComponent is loaded before FluentIcons

### Icons not displaying

If icons don't render:

1. Check that the icon name exists: `rake fluent_icons:scan`
2. Try a different weight: `weight: 24` instead of `weight: 20`
3. Clear the cache: `rake fluent_icons:clear_cache`

## More Information

- [Main README](./README.md)
- [ViewComponent Documentation](https://viewcomponent.org/)
- [Icon Showcase](./showcase.html)
- [Examples](./examples/view_component_example.erb)
