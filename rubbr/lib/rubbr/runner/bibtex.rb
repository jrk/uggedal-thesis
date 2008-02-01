module Rubbr
  module Runner
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
  end
end
