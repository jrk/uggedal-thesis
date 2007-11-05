module Typeraker
  module Runner
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
  end
end
