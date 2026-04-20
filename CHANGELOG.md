# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **ViewComponent support**: Added `FluentIcons::Component` for modern, testable icon rendering
  - Optional integration - only loads if ViewComponent gem is present
  - Same caching performance as helper method
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
