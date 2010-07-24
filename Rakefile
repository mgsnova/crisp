require 'rake/testtask'
require 'spec/rake/spectask'

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
