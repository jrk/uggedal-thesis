task :default => :base

task :base do
  RakedLaTeX::Template.new('Draft: Social Navigation') do |t|
    t.document_class = { :book => %w(11pt a4paper twoside) }

    t.packages << { :hyperref => %w(ps2pdf
                                    bookmarks=true
                                    breaklinks=false
                                    raiselinks=true
                                    pdfborder={0 0 0}
                                    colorlinks=false) }
    t.packages << { :fontenc => ['T1'] }
    t.packages << { :mathpazo => [] }
    t.packages << { :courier => [] }
    t.packages << { :helvet => [] }
    t.packages << { :appendix => %w(titletoc page) }
    t.packages << { :longtable => [] }
    t.packages << { :booktabs => [] }
    t.packages << { :natbib => [] }

    t.author = { :name => 'Eivind Uggedal', :email => 'eivindu@ifi.uio.no' }

    t.scm =  RakedLaTeX::ScmStats::Mercurial.new.collect_scm_stats

    t.table_of_contents = true

    t.main_content = %w(content.analysis)

    t.appendices = %w(content.inventory
                      content.mapping)
  end
end

module RakedLaTeX
  class Template
    require 'erb'

    # Class of the document and it's optional options. Defaults to the
    # article class with no options enabled. Example:
    #
    #   { :book => ['12pt', 'a4paper', 'twoside']
    #
    attr_accessor :document_class

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

    # The author of the document. Example:
    #
    #   { :name => 'Eivind Uggedal',
    #     :email => 'eu@redflavor.com' }
    #
    attr_accessor :author

    # SCM information like name, revision of the tip/head/trunk and it's
    # date. Example:
    #
    #   { :name => 'Mercurial',
    #     :revision => 45,
    #     :date => '12th of August 2005' }
    #
    attr_accessor :scm

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

    def initialize(title=nil)
      @document_class = { :article => [] }
      @packages = []
      @title = title
      @author = nil
      @scm = {}
      @abstract = nil
      @acknowledgments = nil
      @table_of_contents = false
      @list_of_figures = false
      @list_of_tables = false
      @main_content = []
      @appendices = []
      @bibliography = {}

      # TODO: create file_path attr and initialize here and rename
      # generate_result to generate_file

      yield self if block_given?

      generate_result
    end

    def generate_result
      puts ERB.new(template, 0, '%<>').run(self.send('binding'))
    end

    def template
      %q(
        % @document_class.each do |klass, options|
        \documentclass[<%=options.join(',')%>]{<%=klass%>}
        % end

        % @packages.each do |package|
        %   package.each do |name, options|
        \usepackage[<%=options.join(',')%>]{<%=name%>}
        %   end
        % end

        % if @title
        \title{<%=@title%>}
        %   if @author && @author[:name]
        \author{%
          <%=@author[:name]%>
        %     if @author[:email]
          \\\\
          \texttt{<%=@author[:email]%>}
        %     end
        %     if @scm
        %       if @scm[:name]
          \\\\ \\\\ \\\\
          <%=@scm[:name]%> Stats
        %       end
        %       if @scm[:revision]
          \\\\
          \texttt{<%=@scm[:revision]%>}
        %       end
        %       if @scm[:date]
          \\\\
          \texttt{<%=@scm[:date]%>}
        %       end
        %     end
        }
        %   end
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
            \bibliography{file}
        % end
        \end{document}
      ).gsub(/^[ ]{8}/, '')
    end
  end

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module ScmStats
    class Mercurial

      # The name of the Mercurial SCM system. Defaults to this class name.
      attr_accessor :name

      # The Mercurial executable. Defaults to plain `hg` if it's found on the
      # system.
      attr_accessor :executable

      # The revision and date of the tip (Mercurial's head).
      attr_accessor :revision, :date

      def initialize()
        @name = self.class.to_s.gsub(/\w+::/, '')
        @executable = 'hg' if system 'which hg > /dev/null'

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

      def collect_scm_stats
        { :name => @name,
          :revision => @revision,
          :date => @date }
      end


    end

    class Subversion

      # The name of the Subversion SCM system. Defaults to this class name.
      attr_accessor :name

      # The Subversion executable. Defaults to plain `svn` if it's found on
      # the system.
      attr_accessor :executable

      # The revision and date of the last changed revision.
      attr_accessor :revision, :date

      def initialize()
        @name = self.class.to_s.gsub(/\w+::/, '')
        @executable = 'svn' if system 'which svn > /dev/null'

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

      def collect_scm_stats
        { :name => @name,
          :revision => @revision,
          :date => @date }
      end
    end
  end
end
