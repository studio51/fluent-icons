# Fluent::Icons

This gem allows you to use Microsoft's Fluent Icons package in a Rails app through the `fluent()` helper.
This has been extracted from https://games.directory without any other consideration, as such, if it doesn't work for you, you can either open an Issue or Pull Request.

https://github.com/microsoft/fluentui-system-icons

I'm happy to merge anything that'll make this work with any other Rails app.

## Considerations

- Currently, the gem has to be updated manually each time the fluent repository gets updated. Expect weekly updates.
- The gem stores a copy of all SVG images available in the FluentUI Icon library. It's biiiiig!

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

By default, the helper will use `weight: 20` of the SVG icon. However, not all of them have a weight of 20.
If the SVG image is not found, you should try a different weight like so: `fluent('add', weight: 24)`

If you use TailwindCSS, you can change the size and color of the icon with `fluent('add', class: 'w-4 h-4 fill-current text-green-500')`

The gem doesn't do this for you, but you should add a new CSS rule:

TailwindCSS:

```
  .fluent {
    path { @apply fill-current; }
  }
```

Or, plain CSS:

```
  .fluent {
    path { fill-current; }
  }
```

With this, you don't have to apply the `fill-current` class every time.

The 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fluent-icons. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/fluent-icons/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fluent::Icons project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fluent-icons/blob/master/CODE_OF_CONDUCT.md).
