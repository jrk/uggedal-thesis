module Rubbr
  module Viewer

    # View the spesified format.
    def self.view(format)
      case format
      when :dvi
        Rubbr::Viewer::Dvi.new.launch
      when :ps
        Rubbr::Viewer::Ps.new.launch
      else
        Rubbr::Viewer::Pdf.new.launch
      end
    end

    class Base
      include Rubbr::Cli

      # The name prefix of the distribution file. 
      attr_accessor :distribution_name

      def distribution_file
        File.join(Rubbr.options[:distribution_dir],
                  "#@distribution_name.#@view_name")
      end

      def initialize
        @distribution_name = Rubbr.options[:distribution_name]

        @view_name = 'base'
        @executables = []
      end

      def find_viewer
        @executables.each do |executable|
          disable_stdout do
            disable_stderr do
              return executable if system "which #{executable}"
            end
          end
        end
      end

      def launch
        return unless viewer = find_viewer
        system "#{viewer} #{distribution_file}"
        notice "Display of #@view_name completed for: #{@distribution_name}" +
               ".#@view_name in #{Rubbr.options[:distribution_dir]}"
      end
    end

    %w(dvi ps pdf).each do
      |f| require File.dirname(__FILE__) + "/viewer/#{f}"
    end
  end
end
