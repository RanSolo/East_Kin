# -*- encoding: utf-8 -*-
# stub: animate-scss 0.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "animate-scss".freeze
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eric J. Holmes".freeze]
  s.date = "2013-09-28"
  s.description = "Animate.css for the Rails asset pipeline".freeze
  s.email = ["eric@ejholmes.net".freeze]
  s.homepage = "https://github.com/ejholmes/animate.scss".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.32".freeze
  s.summary = "Animate.css for the Rails asset pipeline".freeze

  s.installed_by_version = "3.2.32" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<sass>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<sass>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
