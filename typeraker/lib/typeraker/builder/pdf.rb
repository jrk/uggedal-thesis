module Typeraker
  module Builder
    class Pdf < Base
      def self.build
        @build_name = 'pdf'
        base_ps_file = Typeraker.options[:base_ps_file]

        build_dir do
          dvips = Typeraker::Runner::Ps2Pdf.new(base_ps_file)
        end

        distribute_file(base_ps_file)
        notice "Build of #{@build_name} completed for: #{base_ps_file} " +
               "in #{Typeraker.options[:build_dir]}"
      end
    end
  end
end
