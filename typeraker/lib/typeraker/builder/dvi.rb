module Typeraker
  module Builder
    class Dvi < Base
      def self.build
        @output_format = 'ps'
        base_dvi_file = Typeraker.options[:base_dvi_file]

        build_dir do
          dvips = Typeraker::Runner::DviPs.new(base_dvi_file)
        end

        distribute_file(base_dvi_file)
        notice "Build of #{@output_format} completed for: #{base_dvi_file} " +
               "in #{Typeraker.options[:build_dir]}"
      end
    end
  end
end
