module Typeraker

  # Provides a template for a base latex file. This template can be configured
  # quite extencively by changing many of the class' instance variables. This
  # can easily be done with a block:
  #
  #   Typeraker::Template.new('Dev Null and Nothingness') do |t|
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
    include Typeraker::Cli

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
        %   if @scm
        \scm{%
        %     if @scm[:name]
          \textbf{\Large{<%=@scm[:name]%> SCM statistics}} \\\\
        %     end
        %     if @scm[:revision]
          Revision: <%=@scm[:revision]%> \\\\
        %     end
        %     if @scm[:date]
          Date: <%=@scm[:date]%> \\\\
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
          \chapterstyle{bringhurst}
          \pagestyle{bringhurst}

          \frontmatter
        % if @title
            \maketitle
        % end
        % if @table_of_contents
            \cleardoublepage
            \tableofcontents
        % end
        % if @list_of_figures
            \cleardoublepage
            \listoffigures
        % end
        % if @list_of_tables
            \cleardoublepage
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
        % end
        \end{document}
      ).gsub(/^[ ]{8}/, '')
    end
  end
end
