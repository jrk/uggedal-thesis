module Typeraker

  module Viewer
    class Base
      include Typeraker::Cli

      # The name prefix of the distribution file. 
      attr_accessor :distribution_name

      def distribution_file
        File.join(Typeraker.options[:distribution_dir],
                  "#@distribution_name.#@view_name")
      end

      def initialize(distribution_name)
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
               ".#@view_name in #{Typeraker.options[:distribution_dir]}"
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
end
