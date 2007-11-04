require File.dirname(__FILE__) + '/lib/typeraker'

task :default => 'build:dvi'

task :template => 'template:display'

namespace :template do

  desc 'Displays a base LaTeX file.'
  task :display do
    puts Typeraker::BaseTemplate.new.generate(CONFIG.values)
    puts CONFIG.distribution_name
  end

  desc 'Generate a base LaTeX file in the source dir.'
  task :generate do
    Typeraker::BaseTemplate.new.create_file(CONFIG)
  end
end

task :build => 'build:dvi'

namespace :build do

  desc 'Builds a dvi file of the source files.'
  task :dvi => 'template:generate' do
    Typeraker::Builder::Dvi.new(CONFIG.build_dir,
                                 CONFIG.source_dir,
                                 CONFIG.distribution_dir,
                                 CONFIG.collect_source_files
                                 ).build(CONFIG.base_latex_file,
                                         CONFIG.base_bibtex_file,
                                         CONFIG.distribution_name)
  end

  desc 'Builds a ps file of the source files.'
  task :ps => 'build:dvi' do
    Typeraker::Builder::Ps.new(CONFIG.build_dir,
                                CONFIG.distribution_dir
                                ).build(CONFIG.base_dvi_file,
                                        CONFIG.distribution_name)
  end

  desc 'Builds a pdf file of the source files.'
  task :pdf => 'build:ps' do
    Typeraker::Builder::Pdf.new(CONFIG.build_dir,
                                CONFIG.distribution_dir
                                 ).build(CONFIG.base_ps_file,
                                         CONFIG.distribution_name)
  end
end


task :view => 'view:dvi'

namespace :view do

  desc 'Views a distributed dvi file.'
  task :dvi => 'build:dvi' do
    Typeraker::Viewer::Dvi.new(CONFIG.distribution_dir,
                                CONFIG.distribution_name).launch
  end

  desc 'Views a distributed ps file.'
  task :ps => 'build:ps' do
    Typeraker::Viewer::Ps.new(CONFIG.distribution_dir,
                               CONFIG.distribution_name).launch
  end

  desc 'Views a distributed pdf file.'
  task :pdf => 'build:pdf' do
    Typeraker::Viewer::Pdf.new(CONFIG.distribution_dir,
                                CONFIG.distribution_name).launch
  end
end

desc 'Spell checks source files.'
task :spell do
  Typeraker::Spell.new(CONFIG.source_dir,
                        CONFIG.collect_source_files.grep(/\.tex$/))
end

CONFIG = Typeraker::Config.new do |t|
  t.klass = { :uiothesis => %w(11pt) }

  t.packages << { :fontenc => ['T1'] }
  t.packages << { :mathpazo => [] }
  t.packages << { :courier => [] }
  t.packages << { :helvet => [] }

  t.packages << { :graphicx => [] }

  t.packages << { :longtable => [] }
  t.packages << { :booktabs => [] }
  t.packages << { :lscape => [] }
  t.packages << { :caption => [] }

  t.packages << { :natbib => [] }

  t.title = 'Social Navigation in Modern Web Services:'
  t.sub_title = 'Classification, Prototyping, and Applicability'
  t.author = { :name => 'Eivind Uggedal' }
  t.date = Time.now.strftime('%B %Y')

  t.scm = Typeraker::Scm::Mercurial.new.collect_scm_stats

  t.table_of_contents = true
  t.list_of_figures = true
  t.list_of_tables = true

  t.main_content = %w(introduction
                      content.analysis)

  t.appendices = %w(content.inventory
                    content.mapping)

  t.bibliography = { :bibliography => :apalike }

  t.source_dir = File.dirname(__FILE__) + '/src'
  t.build_dir = File.dirname(__FILE__) + '/build'
  t.distribution_dir = File.dirname(__FILE__) + '/dist'
end
