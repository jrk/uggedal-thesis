module Typeraker
  module Builder
    class Ps < Base
      def initialize(*args)
        super
        @build_name = 'ps'
      end

      def build(base_dvi_file, distribution_name)
        build_dir do
          dvips = Typeraker::Runner::DviPs.new(base_dvi_file)
        end
        distribute_file(base_dvi_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_dvi_file} " +
               "in #{@build_dir}"
      end
    end
  end
end
