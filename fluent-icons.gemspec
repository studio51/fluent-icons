$:.push File.expand_path('lib', __dir__)

require 'fluent/icons/version'

Gem::Specification.new do |spec|
  spec.name          = 'fluent-ui-icons'
  spec.version       = Fluent::Icons::VERSION
  spec.authors       = ['Vlad Radulescu']
  spec.email         = ['oss@studio51.solutions']

  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = 'https://github.com/studio51/fluent-ui-icons'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/studio51/fluent-ui-icons'
  spec.metadata['changelog_uri'] = 'https://github.com/studio51/fluent-ui-icons/blob/main/CHANGELOG.md'

  spec.add_dependency 'nokogiri'
  spec.add_development_dependency 'git'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'progress_bar'
end
