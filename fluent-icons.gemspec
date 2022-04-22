$:.push File.expand_path('lib', __dir__)

require 'fluent-icons/version'

Gem::Specification.new do |spec|
  spec.name          = 'fluent-icons'
  spec.version       = FluentIcons::VERSION
  spec.authors       = ['Vlad Radulescu']
  spec.email         = ['oss@studio51.solutions']

  spec.summary       = 'FluentUI Icon Library + fluent-icons = ♥'
  spec.description   = 'A gem that allows you to use the FluentUI Icons library by Microsoft in your Ruby/Ruby on Rails applications.'
  spec.homepage      = 'https://github.com/studio51/fluent-icons'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.files         = Dir['{lib}/**/*'] + ['LICENSE.txt', 'CODE_OF_CONDUCT.md', 'README.md']

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/studio51/fluent-ui-icons'
  spec.metadata['changelog_uri'] = 'https://github.com/studio51/fluent-ui-icons/blob/main/CHANGELOG.md'

  spec.add_dependency 'railties', '~> 5', '> 5'
  spec.add_dependency 'actionview', '~> 5', '> 5'
  
  spec.add_development_dependency 'git', '~> 1.9'
  spec.add_development_dependency 'progress_bar', '~> 1.3'
end
