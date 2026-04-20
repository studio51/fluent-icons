# -*- encoding: utf-8 -*-
# stub: progress_bar 1.3.4 ruby lib

Gem::Specification.new do |s|
  s.name = "progress_bar".freeze
  s.version = "1.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Paul Sadauskas".freeze]
  s.date = "2024-05-28"
  s.description = "Give people feedback about long-running tasks without overloading them with information: Use a progress bar, like Curl or Wget!".freeze
  s.email = ["psadauskas@gmail.com".freeze]
  s.homepage = "http://github.com/paul/progress_bar".freeze
  s.licenses = ["WTFPL".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.4.19".freeze
  s.summary = "Simple Progress Bar for output to a terminal".freeze

  s.installed_by_version = "3.4.19" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<highline>.freeze, [">= 1.6"])
  s.add_runtime_dependency(%q<options>.freeze, ["~> 2.3.0"])
end
