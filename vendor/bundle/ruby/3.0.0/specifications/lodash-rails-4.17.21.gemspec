# -*- encoding: utf-8 -*-
# stub: lodash-rails 4.17.21 ruby lib

Gem::Specification.new do |s|
  s.name = "lodash-rails".freeze
  s.version = "4.17.21"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Richard Hubers".freeze]
  s.date = "2021-05-11"
  s.description = "lodash for the Rails asset pipeline".freeze
  s.email = ["richard.hubers@gmail.com".freeze]
  s.homepage = "http://github.com/rh/lodash-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.32".freeze
  s.summary = "This gem makes lodash available for the Rails asset pipeline".freeze

  s.installed_by_version = "3.2.32" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
  end
end
