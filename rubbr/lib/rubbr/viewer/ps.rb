module Rubbr
  module Viewer
    class Ps < Base
      def initialize(*args)
        super
        @view_name = 'ps'
        @executables = %w(evince gv)
      end
    end
  end
end
