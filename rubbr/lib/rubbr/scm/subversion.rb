module Rubbr

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module Scm
    class Subversion < Base

      def initialize
        super

        @name = 'Subversion'
        disable_stdout do
          disable_stderr do
            @executable = 'svn' if system 'which svn'
          end
        end

        @revision, @date = parse_scm_stats

        yield self if block_given?
      end

      def parse_scm_stats
        return [nil, nil] unless @executable

        raw_stats = `svn info`
        revision = raw_stats.scan(/^Revision: (\d+)/).first.first
        date = raw_stats.scan(/^Last Changed Date: (.+)/).first.first

        [revision, date]
      end
    end
  end
end
