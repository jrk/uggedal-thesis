module Typeraker

  # Provides configuration options that can be utilized by changing many
  # of the class' instance variables. This can easily be done with a block:
  #
  #   Typeraker::Config.new do |t|
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
  class Config

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

    # Directory for building source files into binary files.
    # Defaults to the same dir as this file is placed in. Note that this
    # is not the same as the current working dir (pwd).
    attr_accessor :build_dir

    # Full file path for the base template file.
    attr_accessor :base_template_file

    # File name for the base latex file. Defaults to 'base.tex'.
    attr_accessor :base_latex_file


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

      @build_dir = File.dirname(__FILE__)
      @base_template_file = nil
      @base_latex_file = 'base.tex'

      yield self if block_given?
    end

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

    # Returns a list of all latex and bibtex source files(main_content,
    # appendices, and bibliography) with file extension (.tex and .bib).
    def collect_source_files
      (@main_content + @appendices).collect { |a| "#{a}.tex" } +
        @bibliography.keys.collect { |a| "#{a}.bib" }
    end

    def values
      binding
    end

    def to_file_name(*names)
      names.collect do |name|
        name.downcase.gsub(/ /, '.').gsub(/:|-/, '')
      end.join('.')
    end
  end
end
