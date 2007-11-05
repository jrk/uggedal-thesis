require File.dirname(__FILE__) + '/lib/typeraker'

task :dev do
  puts Typeraker.config.inspect
end

task :default => 'build:dvi'

task :template => 'template:display'

namespace :template do

  desc 'Displays a base LaTeX file.'
  task :display do
    puts Typeraker::Template.generate
  end

  desc 'Generate a base LaTeX file in the source dir.'
  task :generate do
    Typeraker::Template.create_file
  end
end

task :build => 'build:dvi'

namespace :build do

  desc 'Builds a dvi file of the source files.'
  task :dvi => 'template:generate' do
    Typeraker::Builder::Dvi.new.build
  end

  desc 'Builds a ps file of the source files.'
  task :ps => 'build:dvi' do
    Typeraker::Builder::Ps.new.build
  end

  desc 'Builds a pdf file of the source files.'
  task :pdf => 'build:ps' do
    Typeraker::Builder::Pdf.new.build
  end
end


task :view => 'view:dvi'

namespace :view do

  desc 'Views a distributed dvi file.'
  task :dvi => 'build:dvi' do
    Typeraker::Viewer::Dvi.new.launch
  end

  desc 'Views a distributed ps file.'
  task :ps => 'build:ps' do
    Typeraker::Viewer::Ps.new.launch
  end

  desc 'Views a distributed pdf file.'
  task :pdf => 'build:pdf' do
    Typeraker::Viewer::Pdf.new.launch
  end
end

desc 'Spell checks source files.'
task :spell do
  Typeraker::Spell.new(CONFIG.collect_source_files.grep(/\.tex$/))
end
