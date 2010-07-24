require 'rake/testtask'
require 'spec/rake/spectask'
require 'rake/gempackagetask'

begin
  require 'jeweler'
  $:.unshift('./lib')
  require 'lib/crisp'

  Jeweler::Tasks.new do |gem|
    gem.name = "crisp"
    gem.version = Crisp::VERSION
    gem.summary = 'a tiny lisp-like language written in ruby using treetop.'
    gem.email = "github@mgsnova.de"
    gem.homepage = "http://github.com/mgsnova/crisp"
    gem.authors = ['Markus Gerdes']
    gem.add_dependency 'treetop', '>= 1.4.0'
    gem.add_development_dependency 'rspec', '>= 1.3.0'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

def gemspec
  @gemspec ||= begin
    file = File.expand_path('../crisp.gemspec', __FILE__)
    eval(File.read(file), binding, file)
  end
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.libs << 'lib' << 'spec'
  spec.spec_opts << '--options' << 'spec/spec.opts'
end

task :tt do
  `tt lib/crisp/crisp.treetop`
end

task :default => [:tt, :spec] do
end
