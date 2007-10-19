module RakedLaTeX

  # Provides configuration options that can be utilized by changing many
  # of the class' instance variables. This can easily be done with a block:
  #
  #   RakedLaTeX::Configuration.new do |t|
  #     t.klass = { :book => %w(12pt a4paper twoside) }
  #
  #     t.packages << { :fontenc => ['T1'] }
  #     t.packages << { :natbib => [] }
  #
  #     t.title = 'Dev Null and Nothingness'
  #     t.author = { :name => 'Eivind Uggedal', :email => 'eu@redflavor.com' }
  #
  #     t.table_of_contents = true
  #
  #     t.main_content = %w(introduction previous.research method data)
  #
  #     t.appendices = %w(data.tables concent.forms)
  #   end
  #
  class Configuration

    # Class of the document and it's optional options. Defaults to the
    # article class with no options enabled. Example:
    #
    #   { :book => ['12pt', 'a4paper', 'twoside']
    #
    attr_accessor :klass

    # List of packages to use and their optional options. Example:
    #
    #   [ { :appendix => [:titletoc, :page] },
    #     { :fontenc => ['T1'] },
    #     { :longtable => [] } ]
    #
    attr_accessor :packages

    # Title of the document. No front title will be generated if this value
    # is empty. Examples:
    #
    #   'Types of Social Navigation in Modern Web Applications'
    #
    attr_accessor :title

    # Sub title of the document. Examples:
    #
    #   'An Exploratory Study'
    #
    attr_accessor :sub_title

    # The author of the document. Example:
    #
    #   { :name => 'Eivind Uggedal',
    #     :email => 'eu@redflavor.com' }
    #
    attr_accessor :author

    # The date of the document. Example:
    #
    #   'October 2007'
    #
    attr_accessor :date

    # SCM information like name, revision of the tip/head/trunk and it's
    # date. Example:
    #
    #   { :name => 'Mercurial',
    #     :revision => 45,
    #     :date => '12th of August 2005' }
    #
    attr_accessor :scm

    # Often it's neccessary to include extra configuration, custom commands,
    # etc in the preamble of the document. This hook enables such behaviour.
    # Example:
    #
    #   '\include{my.comstom.commands}'
    #
    #   or
    #
    #   %q(\sloppy
    #      \raggedbottom)
    #
    attr_accessor :preamble_extras

    # The documents abstract. Example:
    #
    #   %q(This document tries to answer some random research question.
    #      This research is important and wort studying because of this and
    #      that. The data used to illuminate this problem is /dev/null and
    #      the method of procrastination is to analyse this naturally
    #      occuring data. The main findings are equal to nil and their
    #      implications in the light of other research is not known.)
    #
    attr_accessor :abstract

    # The documents acknowledgments. Example:
    #
    #   %q(I would like to thank all those who refused to belive in me and
    #      my work for all those years.)
    #
    attr_accessor :acknowledgments

    # Wether to include a table of contents in the document. Defaults to
    # false.
    attr_accessor :table_of_contents

    # Wether to include a list of figures in the document. Defaults to
    # false.
    attr_accessor :list_of_figures

    # Wether to include a list of tables in the document. Defaults to
    # false.
    attr_accessor :list_of_tables

    # List of latex files that will be included in the main matter of the
    # document. Usually this is used to include one file per chapter of the
    # document. The file suffix shuld be ommitted as '.tex' is always
    # appended to these files.
    # Example:
    #
    #   %w(introduction littrature methodology data conclusion)
    #
    attr_accessor :main_content

    # List of latex files that will be included as appendices of the
    # document. The file suffix shuld be ommitted as '.tex' is always
    # appended to these files.
    # Example:
    #
    #   %w(content.inventory content.mapping history)
    #
    attr_accessor :appendices

    # Latex file which will be used as the bibliography and the style to use
    # for it's listings. The file suffix should be omitted as '*.bib' is
    # always appended to this file. Example:
    #
    #   { :citations => :newapa }
    #
    attr_accessor :bibliography

    # Returns a list of all latex and bibtex source files(main_content,
    # appendices, and bibliography) with file extension (.tex and .bib).
    def collect_source_files
      (@main_content + @appendices).collect { |a| "#{a}.tex" } +
        @bibliography.keys.collect { |a| "#{a}.bib" }
    end

    # Directory for outputting the latex file generated from the template and
    # where all it's dependencies should be placed. Defaults to the same
    # dir as this file is placed in. Note that this is not the same as
    # the current working dir (pwd).
    attr_accessor :source_dir

    # Directory for building source files into binary files.
    # Defaults to the same dir as this file is placed in. Note that this
    # is not the same as the current working dir (pwd).
    attr_accessor :build_dir

    # Directory where binary files are placed after a build.
    # Defaults to the same dir as this file is placed in. Note that this
    # is not the same as the current working dir (pwd).
    attr_accessor :distribution_dir

    # File name for the base latex file. Defaults to 'base.tex'.
    attr_accessor :base_latex_file

    # Returns the bibtex counterpart to the base latex file.
    def base_bibtex_file
      @base_latex_file.gsub(/\.tex$/, '.aux') if @base_latex_file
    end

    # Returns the dvi counterpart to the base latex file.
    def base_dvi_file
      @base_latex_file.gsub(/\.tex$/, '.dvi') if @base_latex_file
    end

    # Returns the ps counterpart to the base latex file.
    def base_ps_file
      @base_latex_file.gsub(/\.tex$/, '.ps') if @base_latex_file
    end

    # Returns the pdf counterpart to the base latex file.
    def base_pdf_file
      @base_latex_file.gsub(/\.tex$/, '.pdf') if @base_latex_file
    end

    # File name prefix for distributed files.
    def distribution_name
      to_file_name(@author[:name],
                   @title,
                   "r#{@scm[:revision].gsub(/:\w+/, '')}")
    end

    def initialize
      @klass = { :article => [] }
      @packages = []
      @title = nil
      @sub_title = nil
      @author = nil
      @date = nil
      @scm = {}
      @preamble_extras = nil
      @abstract = nil
      @acknowledgments = nil
      @table_of_contents = false
      @list_of_figures = false
      @list_of_tables = false
      @main_content = []
      @appendices = []
      @bibliography = {}

      @source_dir = File.dirname(__FILE__)
      @build_dir = File.dirname(__FILE__)
      @distribution_dir = File.dirname(__FILE__)
      @base_latex_file = 'base.tex'

      yield self if block_given?
    end

    def values
      binding
    end

    def base_path
      File.join(@source_dir, @base_latex_file)
    end

    def to_file_name(*names)
      names.collect do |name|
        name.downcase.gsub(/ /, '.').gsub(/:|-/, '')
      end.join('.')
    end
  end

  # Handles command line output. Could be useful in the future with regards to
  # verbosity settings and color support.
  module Output
    def notice(message)
      puts message
    end

    def warning(message)
      puts "  - #{message}"
    end

    def error(message)
      puts "  * #{message}"
    end

    def disable_stdout
      old_stdout = STDOUT.dup
      STDOUT.reopen('/dev/null')
      yield
      STDOUT.reopen(old_stdout)
    end

    def disable_stderr
      old_stderr = STDERR.dup
      STDERR.reopen('/dev/null')
      yield
      STDERR.reopen(old_stderr)
    end
  end

  # Provides a template for a base latex file. This template can be configured
  # quite extencively by changing many of the class' instance variables. This
  # can easily be done with a block:
  #
  #   RakedLaTeX::Template.new('Dev Null and Nothingness') do |t|
  #     t.klass = { :book => %w(12pt a4paper twoside) }
  #
  #     t.packages << { :fontenc => ['T1'] }
  #     t.packages << { :natbib => [] }
  #
  #     t.author = { :name => 'Eivind Uggedal', :email => 'eu@redflavor.com' }
  #
  #     t.table_of_contents = true
  #
  #     t.main_content = %w(introduction previous.research method data)
  #
  #     t.appendices = %w(data.tables concent.forms)
  #   end
  #
  class BaseTemplate
    require 'erb'
    include RakedLaTeX::Output

    def create_file(config)
      File.open(config.base_path, 'w') do |f|
        f.puts generate(config.values)
      end
      notice "Creation completed for: #{config.base_latex_file} in " +
             "#{config.source_dir}"
    end

    def generate(values)
      ERB.new(template, 0, '%<>').result(values)
    end

    def template
      %q(
        % @klass.each do |klass, options|
        \documentclass[<%=options.join(',')%>]{<%=klass%>}
        % end

        % @packages.each do |package|
        %   package.each do |name, options|
        \usepackage[<%=options.join(',')%>]{<%=name%>}
        %   end
        % end

        % if @title
        \title{<%=@title%>}
        %   if @sub_title
        \subtitle{<%=@sub_title%>}
        %   end
        %   if @author && @author[:name]
        \author{%
          <%=@author[:name]%>
        %     if @author[:email]
          \\\\
          \texttt{<%=@author[:email]%>}
        %     end
        }
        %   end
        % end

        % if @date
        \date{<%=@date%>}
        % end

        % if @preamble_extras
        <%=@preamble_extras%>
        % end

        % if @abstract
        \documentabstract{%
          <%=@abstract%>
        }
        % end

        % if @acknowledgments
        \acknowledgments{%
          <%=@acknowledgments%>
        }
        % end

        \begin{document}
          \frontmatter
        % if @title
            \maketitle
        % end
        % if @table_of_contents
            \tableofcontents
        % end
        % if @list_of_figures
            \listoffigures
        % end
        % if @list_of_tables
            \listoftables
        % end

          \mainmatter
        % @main_content.each do |content|
            \include{<%=content%>}
        % end

        % if @appendices && @appendices.any?
            \begin{appendices}
        %   @appendices.each do |appendix|
              \include{<%=appendix%>}
        %   end
            \end{appendices}
        % end

          \backmatter
        % @bibliography.each do |file, style|
            \bibliographystyle{<%=style%>}
            \bibliography{<%=file%>}
            \addcontentsline{toc}{chapter}{Bibliography}
        % end
        \end{document}
      ).gsub(/^[ ]{8}/, '')
    end
  end

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module ScmStats
    class Base
      include RakedLaTeX::Output

      # The name of the SCM system. 
      attr_accessor :name

      # The Mercurial executable.
      attr_accessor :executable

      # The revision and date of the tip/head/latest changeset.
      attr_accessor :revision, :date

      def collect_scm_stats
        { :name => @name,
          :revision => @revision,
          :date => @date }
      end
    end

    class Mercurial < Base

      def initialize
        super

        @name = 'Mercurial'
        disable_stdout do
          @executable = 'hg' if system 'which hg'
        end

        @revision, @date = parse_scm_stats

        yield self if block_given?
      end

      def parse_scm_stats
        return [nil, nil] unless @executable

        raw_stats = `hg tip`
        revision = raw_stats.scan(/^changeset: +(.+)/).first.first
        date = raw_stats.scan(/^date: +(.+)/).first.first

        [revision, date]
      end
    end

    class Subversion < Base

      def initialize
        super

        @name = 'Subversion'
        disable_stdout do
          @executable = 'svn' if system 'which svn'
        end

        @revision, @date = parse_scm_stats

        yield self if block_given?
      end

      def parse_scm_stats
        return [nil, nil] unless @executable

        raw_stats = `svn info`
        revision = raw_stats.scan(/^Revision: (\d+)/).first.first
        date = raw_stats.scan(/^Last Changed Date: (.+)/).first.first

        [revision, date]
      end
    end
  end

  # Takes care of running latex and related utilities. Gives helpful
  # information if input files are missing and also cleans up the output of
  # these utilities.
  module Runner
    class Base
      include RakedLaTeX::Output

      # The file to be run trough the latex process.
      attr_accessor :input_file

      # If true no messages is sendt to standard out. Defaults to false.
      attr_accessor :silent

      # The LaTeX executable. Defaults to plain `latex` if it's found on
      # the system.
      attr_accessor :executable

      # Contains a list of possible warnings after a run.
      attr_accessor :warnings

      def initialize(input_file, silent, executable)
        @input_file = input_file
        disable_stdout do
          @executable = executable if system "which #{executable}"
        end
        @silent = silent
        @warnings = []

        if File.exists? @input_file
          run
        else
          error "Running of #@executable aborted. " +
                "Input file: #@input_file not found"
        end
      end

      def run
      end

      def feedback
        unless @warnings.empty? || @silent
          notice "Warnings from #@executable:"
          @warnings.each do |message|
            warning message
          end
        end
      end
    end

    class LaTeX < Base
      def initialize(input_file, silent=false, executable='latex')
        super
      end

      def run
        # TODO: Currently this does not work when latex awaits user input:
        messages = /^(Overfull|Underfull|No file|Package \w+ Warning:)/
        @warnings = `#@executable #@input_file`.grep(messages)
        feedback
      end
    end

    class BibTeX < Base
      def initialize(input_file, silent=false, executable='bibtex')
        super
      end

      def run
        messages = /^I (found no|couldn't open)/
        @warnings = `#@executable #@input_file`.grep(messages)
        feedback
      end
    end

    class DviPs < Base
      def initialize(input_file, silent=false, executable='dvips')
        super
      end

      def run
        disable_stderr do
          @warnings = `#@executable -Ppdf #@input_file`.split("\n")
        end
        feedback
      end
    end

    class Ps2Pdf < Base
      def initialize(input_file, silent=false, executable='ps2pdf')
        super
      end

      def run
        disable_stderr do
          @warnings = `#@executable #@input_file`.split("\n")
        end
      end
    end
  end

  # Handles the business of building latex (and bibtex if needed) source
  # files into binary formats as dvi, ps, and pdf. The latex and bibtex
  # utilites need to be run a certain number of times so that things like
  # table of contents, references, citations, etc become proper. This module
  # tries to solve this issue by running the needed utilities only as many
  # times as needed.
  module Builder
    class Base
      include RakedLaTeX::Output

      # The dir where the files to be built should be located.
      attr_accessor :source_dir

      # The dir where the build should be run. This dir is
      # created if it's not present.
      attr_accessor :build_dir

      # The dir where the buildt files are placed. This dir is
      # created if it's not present.
      attr_accessor :distribution_dir

      # List of source files that are part of the build. If such a list is
      # present all files are verified of existence before the process
      # proceeds.
      attr_accessor :source_files

      def initialize(build_dir, distribution_dir)
        @build_dir = build_dir
        @distribution_dir = distribution_dir

        @build_name = 'base'
      end

      def build_dir
        prepare_dir(@build_dir) do
          yield
        end
      end

      def distribute_file(base_file, distribution_file)
        prepare_dir(@distribution_dir) do
          cp(File.join(@build_dir,
                       "#{base_file.gsub(/.\w+$/, '')}.#@build_name"),
             File.join(@distribution_dir,
                       "#{distribution_file}.#@build_name"))
        end
      end

      def prepare_dir(dir)
        if dir
          mkdir_p dir unless File.exists? dir
          cd dir do
            yield
          end
        else
          yield
        end
      end
    end

    class Dvi < Base
      def initialize(build_dir, source_dir, distribution_dir, source_files=[])
        super(build_dir, distribution_dir)
        @source_dir = source_dir
        @source_files = source_files

        @build_name = 'dvi'
      end

      def build(base_latex_file, base_bibtex_file=nil, distribution_name=nil)
        clean_build_dir
        build_dir do
          copy_source_files
          return unless source_files_present?

          latex = RakedLaTeX::Runner::LaTeX.new(base_latex_file, true)
          if base_bibtex_file && latex.warnings.join =~ /No file .+\.bbl/
            bibtex = RakedLaTeX::Runner::BibTeX.new(base_bibtex_file, true)
          end
          if latex.warnings.join =~ /No file .+\.(aux|toc)/
            latex = RakedLaTeX::Runner::LaTeX.new(base_latex_file, true)
          end
          if latex.warnings.join =~ /There were undefined citations/
            latex = RakedLaTeX::Runner::LaTeX.new(base_latex_file, true)
          end
          latex.silent = false
          latex.feedback
          if bibtex
            bibtex.silent = false
            bibtex.feedback
          end
        end
        distribute_file(base_latex_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_latex_file} " +
               "in #{@build_dir}"
      end

      def clean_build_dir
        rm_r @build_dir if File.exists? @build_dir
      end

      def copy_source_files
        %w(tex bib sty cls eps jpg).each do |file_extension|
          FileList["#{@source_dir}/*.#{file_extension}"].each do |file|
            cp(file,  @build_dir)
          end
        end
      end

      def source_files_present?
        @source_files.each do |file|
          unless File.exists? file
            error "Build of #@build_name aborted. " +
                  "Source file: #{file} not found"
            return false
          end
        end
        true
      end
    end

    class Ps < Base
      def initialize(*args)
        super
        @build_name = 'ps'
      end

      def build(base_dvi_file, distribution_name)
        build_dir do
          dvips = RakedLaTeX::Runner::DviPs.new(base_dvi_file)
        end
        distribute_file(base_dvi_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_dvi_file} " +
               "in #{@build_dir}"
      end
    end

    class Pdf < Base
      def initialize(*args)
        super
        @build_name = 'pdf'
      end

      def build(base_ps_file, distribution_name)
        build_dir do
          dvips = RakedLaTeX::Runner::Ps2Pdf.new(base_ps_file)
        end
        distribute_file(base_ps_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_ps_file} " +
               "in #{@build_dir}"
      end
    end
  end

  module Viewer
    class Base
      include RakedLaTeX::Output
      # The dir where distributed files are placed. 

      attr_accessor :distribution_dir

      # The name prefix of the distribution file. 
      attr_accessor :distribution_name

      def distribution_file
        File.join(@distribution_dir, "#@distribution_name.#@view_name")
      end

      def initialize(distribution_dir, distribution_name)
        @distribution_dir = distribution_dir
        @distribution_name = distribution_name

        @view_name = 'base'
        @executables = []
      end

      def find_viewer
        @executables.each do |executable|
          disable_stdout do
            return executable if system "which #{executable}"
          end
        end
      end

      def launch
        return unless viewer = find_viewer
        system "#{viewer} #{distribution_file}"
        notice "Display of #@view_name completed for: #{distribution_name}" +
               ".#@view_name in #{@distribution_dir}"
      end
    end

    class Dvi < Base
      def initialize(*args)
        super
        @view_name = 'dvi'
        @executables = %w(evince xdvi kdvi)
      end
    end

    class Ps < Base
      def initialize(*args)
        super
        @view_name = 'ps'
        @executables = %w(evince gv)
      end
    end

    class Pdf < Base
      def initialize(*args)
        super
        @view_name = 'pdf'
        @executables = %w(evince acroread xpdf gv)
      end
    end
  end

  class Spell
      # The dir where the files to be spell checked should be located.
      attr_accessor :source_dir

      # List of source files that are slated for spell checking.
      attr_accessor :source_files

    def initialize(source_dir, source_files)
      @source_dir = source_dir
      @source_files = source_files

      spell_check
    end

    def spell_check
      dictionary_path = File.join(@source_dir, 'dictionary.ispell')
      @source_files.each do |file|
        file_path = File.join(@source_dir, file)
        system "ispell -t -p #{dictionary_path} #{file_path}"
      end
    end
  end
end

task :default => 'build:dvi'

task :template => 'template:display'

namespace :template do

  desc 'Displays a base LaTeX file.'
  task :display do
    puts RakedLaTeX::BaseTemplate.new.generate(CONFIG.values)
    puts CONFIG.distribution_name
  end

  desc 'Generate a base LaTeX file in the source dir.'
  task :generate do
    RakedLaTeX::BaseTemplate.new.create_file(CONFIG)
  end
end

task :build => 'build:dvi'

namespace :build do

  desc 'Builds a dvi file of the source files.'
  task :dvi => 'template:generate' do
    RakedLaTeX::Builder::Dvi.new(CONFIG.build_dir,
                                 CONFIG.source_dir,
                                 CONFIG.distribution_dir,
                                 CONFIG.collect_source_files
                                 ).build(CONFIG.base_latex_file,
                                         CONFIG.base_bibtex_file,
                                         CONFIG.distribution_name)
  end

  desc 'Builds a ps file of the source files.'
  task :ps => 'build:dvi' do
    RakedLaTeX::Builder::Ps.new(CONFIG.build_dir,
                                CONFIG.distribution_dir
                                ).build(CONFIG.base_dvi_file,
                                        CONFIG.distribution_name)
  end

  desc 'Builds a pdf file of the source files.'
  task :pdf => 'build:ps' do
    RakedLaTeX::Builder::Pdf.new(CONFIG.build_dir,
                                CONFIG.distribution_dir
                                 ).build(CONFIG.base_ps_file,
                                         CONFIG.distribution_name)
  end
end


task :view => 'view:dvi'

namespace :view do

  desc 'Views a distributed dvi file.'
  task :dvi => 'build:dvi' do
    RakedLaTeX::Viewer::Dvi.new(CONFIG.distribution_dir,
                                CONFIG.distribution_name).launch
  end

  desc 'Views a distributed ps file.'
  task :ps => 'build:ps' do
    RakedLaTeX::Viewer::Ps.new(CONFIG.distribution_dir,
                               CONFIG.distribution_name).launch
  end

  desc 'Views a distributed pdf file.'
  task :pdf => 'build:pdf' do
    RakedLaTeX::Viewer::Pdf.new(CONFIG.distribution_dir,
                                CONFIG.distribution_name).launch
  end
end

desc 'Spell checks source files.'
task :spell do
  RakedLaTeX::Spell.new(CONFIG.source_dir,
                        CONFIG.collect_source_files.grep(/\.tex$/))
end

CONFIG = RakedLaTeX::Configuration.new do |t|
  t.klass = { :uiothesis => %w(11pt final) }

  t.packages << { :fontenc => ['T1'] }
  t.packages << { :mathpazo => [] }
  t.packages << { :courier => [] }
  t.packages << { :helvet => [] }

  t.packages << { :appendix => %w(titletoc page) }

  t.packages << { :longtable => [] }
  t.packages << { :booktabs => [] }
  t.packages << { :lscape => [] }

  t.packages << { :natbib => [] }

  t.title = 'Social Navigation in Modern Web Services:'
  t.sub_title = 'Classification, Prototyping, and Applicability'
  t.author = { :name => 'Eivind Uggedal' }
  t.date = Time.now.strftime('%B %Y')

  t.scm = RakedLaTeX::ScmStats::Mercurial.new.collect_scm_stats

  t.table_of_contents = true
  t.list_of_figures = true
  t.list_of_tables = true

  t.main_content = %w(introduction
                      content.analysis)

  t.appendices = %w(content.inventory
                    content.mapping)

  t.bibliography = { :bibliography => :apalike }

  t.source_dir += '/src'
  t.build_dir += '/build'
  t.distribution_dir += '/dist'
end
