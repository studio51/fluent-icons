module FluentIcons
  VERSION = '2.0'.freeze
end

# What's new in v2.0?

# - Removed deprecated options for `width`, `height`, and, `prefix`
# - Removed the generated SVG from the build folder, which should decrease the gem size. Instead, all the SVG is now read from the `data.json` file.
# - Improved performance, slightly, by optimizing the `FluentIcons::Fluent` class and introducing lazy loading
# - Added new errors for when the weight option is used and the Icon doesn't have that weight.
#