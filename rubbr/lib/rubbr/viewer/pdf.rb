module Rubbr
  module Viewer
    class Pdf < Base
      def initialize(*args)
        super
        @view_name = 'pdf'
        @executables = %w(evince acroread xpdf gv)
      end
    end
  end
end
