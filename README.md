# Fluent::Icons

This gem allows you to use Microsoft's Fluent Icons package in a Rails app through the `fluent()` helper.
This has been extracted from https://games.directory without any other consideration, as such, if it doesn't work for you, you can either open an Issue or Pull Request.

https://github.com/microsoft/fluentui-system-icons

I'm happy to merge anything that'll make this work with any other Rails app.

## Considerations

- Currently, the gem has to be updated manually each time the fluent repository gets updated. Expect weekly updates.
- The gem stores a copy of all SVG images available in the FluentUI Icon library. It's beefy!

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

## ToDo

- [ ] Add a ViewComponent option
- [ ] Add CSS fonts
- [x] Get rid of Nokogiri
- [x] Find a better way to store the icons. (updated: They are now stored in a JSON file)
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
