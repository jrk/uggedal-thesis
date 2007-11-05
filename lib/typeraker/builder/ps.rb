module Typeraker
  module Builder
    class Ps < Base
      def initialize(*args)
        @build_name = 'ps'
      end

      def build
        base_dvi_file = Typeraker.options[:base_dvi_file]
        build_dir do
          dvips = Typeraker::Runner::DviPs.new(base_dvi_file)
        end
        distribute_file(base_dvi_file)
        notice "Build of #{@build_name} completed for: #{base_dvi_file} " +
               "in #{Typeraker.options[:build_dir]}"
      end
    end
  end
end
