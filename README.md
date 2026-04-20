# Fluent Icons

Microsoft's Fluent UI System Icons for Ruby on Rails and React applications.

This project provides two packages:
- **Ruby Gem**: For Ruby on Rails applications
- **React Library**: For React/Next.js applications

https://github.com/microsoft/fluentui-system-icons

## Quick Links

- [Rails Gem Documentation](#rails-gem) (below)
- [React Library Documentation](./react/README.md)
- [Icon Showcase](./showcase.html) - Browse all 2,998 icons

---

## Rails Gem

This gem allows you to use Microsoft's Fluent Icons package in a Rails app through the `fluent()` helper.

## Performance & Optimization

This gem now includes advanced caching and compilation features to optimize performance:

- **File-based caching**: Rendered SVGs are cached to disk for faster subsequent loads
- **Lazy loading**: Icon data is loaded efficiently with support for compiled subsets
- **Production compilation**: Scan your app and compile a minimal icon set (can reduce from 22MB to <100KB!)
- **Reduced gem size**: SVG files are excluded from distribution (~13MB → ~1-2MB gem size)

## Automatic Updates

This gem is **automatically updated daily** via GitHub Actions! When Microsoft releases new icons to the FluentUI System Icons repository:

- ✅ Icons are automatically downloaded and processed
- ✅ Gem version is updated to match FluentUI version
- ✅ New version is published to RubyGems automatically
- ✅ GitHub release is created with changelog

See [Automation Documentation](./.github/AUTOMATION.md) for details.

## Considerations

- SVG source files are kept in the repository but excluded from the distributed gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-icons'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fluent-icons

## Usage

### Plain Ruby
```ruby
FluentIcons::Fluent.new('add', style: 'regular', weight: 20, **options)
```

### Rails Helper
```erb
<%= fluent('add', style: 'regular', weight: 20, **options) %>
```

### ViewComponent Integration (Optional)

FluentIcons can optionally use [ViewComponent](https://viewcomponent.org/) for rendering - providing better testability and Rails 7.1+ compatibility.

#### Setup

1. Add ViewComponent to your Gemfile:
```ruby
gem 'view_component'
gem 'fluent-icons'
```

2. Run bundle install:
```bash
bundle install
```

3. Generate the configuration file:
```bash
rails generate fluent_icons:install
```

4. Enable ViewComponent in `config/initializers/fluent_icons.rb`:
```ruby
FluentIcons.configure do |config|
  config.use_view_component = true
end
```

That's it! The `fluent()` helper will now use ViewComponent internally - no code changes needed!

#### Usage

```erb
<!-- Same helper syntax works with or without ViewComponent -->
<%= fluent('add', style: 'regular', weight: 20) %>

<!-- When ViewComponent is enabled, it's used internally -->
<%= fluent('delete', style: 'filled', class: 'w-6 h-6 text-red-500') %>

<!-- Works with data attributes for Hotwire/Turbo -->
<%= fluent('refresh', data: { action: 'click->refresh#icon' }) %>
```

**Benefits when ViewComponent is enabled:**
- ✅ Better testability (write ViewComponent tests)
- ✅ Better compatibility with Rails 7.1+
- ✅ Follows ViewComponent patterns
- ✅ Same exact syntax - zero code changes needed

**Advanced:** You can also render the component directly if preferred:
```erb
<%= render FluentIcons::Component.new(name: "add", style: "filled") %>
```

👉 **[Full ViewComponent Documentation](./VIEW_COMPONENT.md)**
📋 **[Configuration Guide](./CONFIGURATION.md)**

### Styling

By default, the helper will use `weight: 20` of the SVG icon. However, not all of them have a weight of 20.
If the SVG image is not found, you should try a different weight like so: `fluent('add', weight: 24)`

With TailwindCSS, you can change the size and color of the icon with `fluent('add', class: 'w-4 h-4 fill-current text-green-500')`

To avoid having to add the `fill-current` class each time, you can add these CSS rules:

```css
.fluent path { @apply fill-current; } /* TailwindCSS with JIT */
.fluent path { fill: currentColor; } /* Plain CSS */
```

## Production Optimization

### Compiling Icons for Production

To dramatically reduce memory usage and improve startup time, you can compile a minimal `data.json` file containing only the icons your app uses:

```bash
# Scan your app and compile used icons
rake fluent_icons:compile
```

This will:
1. Scan all `.erb`, `.slim`, `.tsx`, `.ts`, `.jsx`, `.js`, and `.rb` files in `app/`
2. Find all `fluent()` and `fluent_icon()` calls
3. Generate `lib/build/data.compiled.json` with only those icons
4. Typically reduces from ~22MB to <100KB (99%+ reduction!)

The compiled file is automatically used in production (`RAILS_ENV=production`).

### Available Rake Tasks

```bash
# Scan and show icon usage report
rake fluent_icons:scan

# Compile minimal icon set for production
rake fluent_icons:compile

# Verify all icons in your app exist
rake fluent_icons:verify

# Show cache statistics
rake fluent_icons:cache_stats

# Clear the file cache
rake fluent_icons:clear_cache

# Show gem statistics
rake fluent_icons:stats
```

### Caching

The gem uses a two-layer caching system:

1. **In-memory cache**: Fast, per-request caching (as before)
2. **File-based cache**: Persistent cache stored in `tmp/cache/fluent-icons/` (Rails) or system temp directory

Cache files expire after 1 hour and can be cleared with:

```ruby
FluentIcons::Cache.clear
```

Or via Rake:

```bash
rake fluent_icons:clear_cache
```

### Environment Variables

- `FLUENT_ICONS_USE_COMPILED=true` - Force use of compiled data.json (even in development)
- `RAILS_ENV=production` - Automatically uses compiled data.json if available

## ToDo

- [x] Add a ViewComponent option (updated: ViewComponent support added with opt-in configuration)
- [ ] Add CSS fonts
- [x] Get rid of Nokogiri
- [x] Find a better way to store the icons. (updated: They are now stored in a JSON file)
- [x] Add caching system (updated: File-based + in-memory caching implemented)
- [x] Optimize gem size (updated: SVG files excluded from distribution)
- [x] Production compilation support (updated: Scan and compile minimal icon sets)
- [x] Use Github Actions to update the build folder and generate the required schema automatically on new releases (updated: Daily automated updates with auto-publish to RubyGems)
- [x] <s>Add a way to search them on Github Pages</s> (updated: https://fluenticons.co/ is pretty good)
- [ ] Render raw SVG, instead of images, when previewing so we can dynamically set color and size, if needed
- [ ] Include TailwindCSS extension to allow for dynamic color and size when rendering the icon

## Manual Update (Maintainers)

Icons are automatically updated daily via GitHub Actions (see [Automation Documentation](./.github/AUTOMATION.md)).

For manual updates, run:

```bash
bin/update
```

This will:
1. Clone the FluentUI Icon library
2. Copy icons to `lib/build/svg/`
3. Generate the new `data.json` with updated schema
4. Clean up temporary files

After manual update, remember to:
1. Update version in `lib/fluent-icons/version.rb`
2. Commit changes
3. Create git tag
4. Build and publish gem

---

## React Library

For React applications, we provide a separate npm package with TypeScript support.

### Installation

```bash
npm install @fluent-icons/react
# or
yarn add @fluent-icons/react
```

### Usage

```tsx
import { FluentIcon } from '@fluent-icons/react';

function App() {
  return (
    <div>
      <FluentIcon name="add" size={20} style="regular" />
      <FluentIcon name="delete" size={24} style="filled" className="text-red-500" />
    </div>
  );
}
```

### Features

- ✅ **TypeScript support** - Full type definitions included
- ✅ **Tree-shakeable** - Only bundle icons you use
- ✅ **2,998 icons** - All Fluent UI System Icons
- ✅ **Multiple styles** - Regular, filled, and more
- ✅ **Flexible sizing** - Any size supported
- ✅ **Tailwind-friendly** - Easy to style with utility classes
- ✅ **Accessibility** - Built-in aria-label support
- ✅ **Utility functions** - Search, filter, and discover icons

### Documentation

Full React documentation available at [./react/README.md](./react/README.md)

### Building the React Package

```bash
cd react
npm install
npm run build
```

---

## Development

After checking out the repo, run `bin/setup` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/studio51/fluent-ui-icons. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/studio51/fluent-ui-icons/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fluent::Icons project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/studio51/fluent-ui-icons/blob/main/CODE_OF_CONDUCT.md).
