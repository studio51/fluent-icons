# Fluent::Icons

This gem allows you to use Microsoft's Fluent Icons package in a Rails app through the `fluent()` helper.
This has been extracted from https://games.directory without any other consideration, as such, if it doesn't work for you, you can either open an Issue or Pull Request.

https://github.com/microsoft/fluentui-system-icons

I'm happy to merge anything that'll make this work with any other Rails app.

## Performance & Optimization

This gem now includes advanced caching and compilation features to optimize performance:

- **File-based caching**: Rendered SVGs are cached to disk for faster subsequent loads
- **Lazy loading**: Icon data is loaded efficiently with support for compiled subsets
- **Production compilation**: Scan your app and compile a minimal icon set (can reduce from 22MB to <100KB!)
- **Reduced gem size**: SVG files are excluded from distribution (~13MB → ~1-2MB gem size)

## Considerations

- Currently, the gem has to be updated manually each time the fluent repository gets updated. Expect weekly updates.
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

Plain Ruby `FluentIcons::Fluent.new('add', style: 'regular', weight: 20, **options)`
Rails `fluent('add', style: 'regular', weight: 20, **options)`

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

- [ ] Add a ViewComponent option
- [ ] Add CSS fonts
- [x] Get rid of Nokogiri
- [x] Find a better way to store the icons. (updated: They are now stored in a JSON file)
- [x] Add caching system (updated: File-based + in-memory caching implemented)
- [x] Optimize gem size (updated: SVG files excluded from distribution)
- [x] Production compilation support (updated: Scan and compile minimal icon sets)
- [ ] Use Github Actions to update the build folder and generate the required schema automatically on new releases
- [x] <s>Add a way to search them on Github Pages</s> (updated: https://fluenticons.co/ is pretty good)
- [ ] Render raw SVG, instead of images, when previewing so we can dynamically set color and size, if needed
- [ ] Include TailwindCSS extension to allow for dynamic color and size when rendering the icon

## Update

To update the icons, run `bin/update`. This will copy all the icons from the FluentUI Icon library to the `lib/data/svg` directory and create the new `data.json` with the updated schema.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/studio51/fluent-ui-icons. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/studio51/fluent-ui-icons/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fluent::Icons project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/studio51/fluent-ui-icons/blob/main/CODE_OF_CONDUCT.md).
