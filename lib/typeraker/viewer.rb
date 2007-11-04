module Typeraker

  module Viewer
    class Base
      include Typeraker::Cli

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
