module Typeraker
  module Builder
    class Ps < Base
      def self.build
        @output_format = 'pdf'
        base_ps_file = Typeraker.options[:base_ps_file]

        build_dir do
          dvips = Typeraker::Runner::Ps2Pdf.new(base_ps_file)
        end

        distribute_file(base_ps_file)
        notice "Build of #{@output_format} completed for: #{base_ps_file} " +
               "in #{Typeraker.options[:build_dir]}"
      end
    end
  end
end
