# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twpipe}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["koshigoe"]
  s.date = %q{2010-09-25}
  s.default_executable = %q{twpipe}
  s.description = %q{This is a simply Twitter Command-Line client.}
  s.email = %q{KoshigoeBushou@gmail.com}
  s.executables = ["twpipe"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "bin/twpipe",
     "lib/twpipe.rb",
     "lib/twpipe/version.rb",
     "spec/data/config/invalid.yml",
     "spec/data/config/syntax_error.yml",
     "spec/data/config/valid.yml",
     "spec/lib/twpipe_spec.rb",
     "spec/spec.opts",
     "twpipe.gemspec"
  ]
  s.homepage = %q{http://github.com/koshigoe/twpipe}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{This is a simply Twitter Command-Line client.}
  s.test_files = [
    "spec/lib/twpipe_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<twitter>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<twitter>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<twitter>, [">= 0"])
  end
end

