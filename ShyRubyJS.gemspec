# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ShyRubyJS}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Shy Inc.}, %q{Daniel Bryan}, %q{Cerales}]
  s.date = %q{2011-08-16}
  s.description = %q{Little library to convert Ruby blocks into JavaScript code, via S Expressions. Work in progress.}
  s.email = %q{danbryan@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "ShyRubyJS.gemspec",
    "VERSION",
    "lib/ShyRubyJS.rb",
    "pkg/ShyRubyJS-0.0.0.gem",
    "pkg/ShyRubyJS-0.0.1.gem",
    "test/examples.rb",
    "test/helper.rb",
    "test/test_ShyRubyJS.rb"
  ]
  s.homepage = %q{http://github.com/Cerales/ShyRubyJS}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Little library to convert Ruby blocks into JavaScript code, via S Expressions. Work in progress.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<sourcify>, ["~> 0.5.0"])
      s.add_runtime_dependency(%q<sourcify>, ["~> 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<sourcify>, ["~> 0.5.0"])
      s.add_dependency(%q<sourcify>, ["~> 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<sourcify>, ["~> 0.5.0"])
    s.add_dependency(%q<sourcify>, ["~> 0"])
  end
end

