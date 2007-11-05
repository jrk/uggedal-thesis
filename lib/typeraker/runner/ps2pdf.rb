module Typeraker
  module Runner
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
end
