require 'optparse'

module Typeraker
  class Main
    class << self

      def run(args = ARGV)
        options = {}

        opts = OptionParser.new do |opts|
          opts.on("--format [FORMAT]", [:dvi, :ps, :pdf],
            "Select output format (dvi, ps, pdf)") do |format|
            options[:format] = format
          end
        end

        opts.parse!(args)
        view(options[:format])
      end

      private

        def build(format)
          Typeraker::Builder.build(format)
        end

        def view(format)
          build(format)
          Typeraker::Viewer.view(format)
        end

        def spell
          Typeraker::Spell.check
        end
    end
  end
end
