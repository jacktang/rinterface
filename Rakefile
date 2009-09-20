require 'rubygems'
require 'rake'
require 'rake/clean'
CLEAN   << FileList['**/*.dump']
CLOBBER << FileList['**/*.beam']
SRC  = FileList['**/*.erl']
OBJ  = SRC.ext("beam") #)pathmap("%{examples,spec}X.beam")
ERLC_FLAGS = "-Iinclude +warn_unused_vars +warn_unused_import"
START_MODULE = "math_server"

# Gem
#
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rinterface"
    gem.summary = "Erlang RPC Ruby Client"
    gem.description = "Pure Ruby client that can send RPC calls to an Erlang node"
    gem.email = "r@interf.ace"
    gem.homepage = "http://github.com/davebryson/rinterface"
    gem.authors = ["Dave Bryson"]
    gem.add_development_dependency "rspec"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

# Compile
#
rule ".beam" =>  ".erl" do |t|
  sh "erlc -o #{t.name.split("/")[0]} -W #{ERLC_FLAGS} #{t.source}"
end

desc "Compile all"
task :compile =>  OBJ
task :default => :compile

# Shell
#
desc "Open up a shell"
task :shell => [:compile] do
    sh("erl -sname rinterface -pa examples")
end

desc "Open up a shell and run #{START_MODULE}:start()"
task :run => [:compile] do
    sh("erl -W -pa examples -sname math -s #{START_MODULE}")
end

# Spec
#
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end
task :spec => :check_dependencies

# RDoc
#
require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rinterface #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
