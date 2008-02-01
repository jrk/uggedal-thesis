module Rubbr
  module Viewer
    class Dvi < Base
      def initialize(*args)
        super
        @view_name = 'dvi'
        @executables = %w(evince xdvi kdvi)
      end
    end
  end
end
