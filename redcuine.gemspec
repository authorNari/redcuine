# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{redcuine}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Narihiro Nakmaura"]
  s.date = %q{2011-01-29}
  s.default_executable = %q{redissue}
  s.description = %q{CUI toolkit for Redmine}
  s.email = %q{authornari@gmail.com}
  s.executables = ["redissue"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LISENCE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/redissue",
    "lib/redcuine.rb",
    "lib/redcuine/active_resource_ext.rb",
    "lib/redcuine/active_resource_ext/print_rest.rb",
    "lib/redcuine/base.rb",
    "lib/redcuine/config_setup.rb",
    "lib/redcuine/config_template.erb",
    "lib/redcuine/issue.rb",
    "lib/redcuine/optparser.rb",
    "lib/redcuine/resource.rb",
    "redcuine.gemspec"
  ]
  s.homepage = %q{https://github.com/authorNari/redcuine}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{CUI toolkit for Redmine}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<active_resource>, [">= 3.0.3"])
    else
      s.add_dependency(%q<active_resource>, [">= 3.0.3"])
    end
  else
    s.add_dependency(%q<active_resource>, [">= 3.0.3"])
  end
end

