# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Automatic daily updates via GitHub Actions**: Icons are now automatically updated
  - Daily check for new FluentUI System Icons releases
  - Automatic version bumping based on FluentUI version
  - Automatic gem build and publish to RubyGems
  - Automatic GitHub release creation with changelog
  - Full documentation in .github/AUTOMATION.md
  - Manual trigger option available
- **Opt-in ViewComponent integration**: The `fluent()` helper can optionally use ViewComponent when enabled
  - Configuration-based opt-in via `FluentIcons.configure`
  - Generate configuration file with `rails generate fluent_icons:install`
  - Enable with `config.use_view_component = true` in initializer
  - Zero code changes required in views - existing `fluent()` calls work unchanged
  - Gracefully falls back to direct SVG rendering when disabled
  - Can also use `FluentIcons::Component` directly for advanced use cases
  - Full documentation in VIEW_COMPONENT.md
  - Example usage in examples/view_component_example.erb
- File-based caching system for rendered SVGs
- Lazy loading of icon data with support for compiled subsets
- Production compilation via `rake fluent_icons:compile` (reduces from 22MB to <100KB)
- Multiple rake tasks: `scan`, `compile`, `verify`, `cache_stats`, `clear_cache`, `stats`
- SVG files excluded from gem distribution (reduced gem size from ~13MB to ~1-2MB)

### Changed
- Optimized icon data loading with lazy loader
- Icons now stored in JSON format instead of individual SVG files
- Improved performance with two-layer caching (in-memory + file-based)

### Fixed
- Memory usage and startup time improvements
- Better support for Rails 7.1+ and 8.0

## Previous Versions

See git history for changes prior to this changelog.
