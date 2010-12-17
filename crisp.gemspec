# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{crisp}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Markus Gerdes"]
  s.date = %q{2010-12-17}
  s.default_executable = %q{crisp}
  s.email = %q{github@mgsnova.de}
  s.executables = ["crisp"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "LICENSE",
    "README.md",
    "Rakefile",
    "bin/crisp",
    "crisp.gemspec",
    "lib/crisp.rb",
    "lib/crisp/chained_env.rb",
    "lib/crisp/crisp.treetop",
    "lib/crisp/env.rb",
    "lib/crisp/errors.rb",
    "lib/crisp/function.rb",
    "lib/crisp/function_runner.rb",
    "lib/crisp/functions.rb",
    "lib/crisp/functions/arithmetic.rb",
    "lib/crisp/functions/core.rb",
    "lib/crisp/native_call_invoker.rb",
    "lib/crisp/nodes.rb",
    "lib/crisp/nodes/array_literal.rb",
    "lib/crisp/nodes/base.rb",
    "lib/crisp/nodes/block.rb",
    "lib/crisp/nodes/false_literal.rb",
    "lib/crisp/nodes/float_literal.rb",
    "lib/crisp/nodes/integer_literal.rb",
    "lib/crisp/nodes/nil_literal.rb",
    "lib/crisp/nodes/operation.rb",
    "lib/crisp/nodes/primitive.rb",
    "lib/crisp/nodes/string_literal.rb",
    "lib/crisp/nodes/symbol_literal.rb",
    "lib/crisp/nodes/true_literal.rb",
    "lib/crisp/parser.rb",
    "lib/crisp/runtime.rb",
    "lib/crisp/shell.rb",
    "spec/crisp/arithmetics_spec.rb",
    "spec/crisp/basic_spec.rb",
    "spec/crisp/core_spec.rb",
    "spec/crisp/function_spec.rb",
    "spec/crisp/internal_spec.rb",
    "spec/crisp/native_call_invoker_spec.rb",
    "spec/crisp/string_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/mgsnova/crisp}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{a tiny lisp-like language written in ruby using treetop.}
  s.test_files = [
    "spec/crisp/arithmetics_spec.rb",
    "spec/crisp/basic_spec.rb",
    "spec/crisp/core_spec.rb",
    "spec/crisp/function_spec.rb",
    "spec/crisp/internal_spec.rb",
    "spec/crisp/native_call_invoker_spec.rb",
    "spec/crisp/string_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<treetop>, ["~> 1.4.9"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
    else
      s.add_dependency(%q<treetop>, ["~> 1.4.9"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    end
  else
    s.add_dependency(%q<treetop>, ["~> 1.4.9"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
  end
end

