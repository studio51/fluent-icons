# ViewComponent Support

FluentIcons now supports [ViewComponent](https://viewcomponent.org/) for a more modern, testable approach to rendering icons in Rails applications.

## Installation

1. Add ViewComponent to your Gemfile (if not already installed):

```ruby
gem 'view_component'
gem 'fluent-icons'
```

2. Run bundle install:

```bash
bundle install
```

That's it! The FluentIcons::Component will be automatically available if ViewComponent is detected.

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

## Comparison with Helper Method

### Helper Method
```erb
<%= fluent('add', style: 'filled', weight: 24, class: 'icon') %>
```

### ViewComponent
```erb
<%= render FluentIcons::Component.new(
  name: 'add',
  style: 'filled',
  weight: 24,
  class: 'icon'
) %>
```

**Benefits of ViewComponent:**
- ✅ More testable (can write component tests)
- ✅ Better IDE autocomplete
- ✅ More explicit and readable
- ✅ Follows ViewComponent patterns in your app
- ✅ Same caching performance as helper

**When to use the helper:**
- ✨ Quick inline icons
- ✨ You don't use ViewComponent in your app
- ✨ Prefer simpler syntax

Both methods are fully supported and use the same underlying caching system!

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
