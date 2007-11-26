module Typeraker

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module Scm
    class Mercurial < Base

      def initialize
        super

        @name = 'Mercurial'
        disable_stdout do
          disable_stderr do
            @executable = 'hg' if system 'which hg'
          end
        end

        @revision, @date = parse_scm_stats

        yield self if block_given?
      end

      def parse_scm_stats
        return [nil, nil] unless @executable

        raw_stats = `hg tip`
        revision = raw_stats.scan(/^changeset: +(.+)/).first.first
        date = raw_stats.scan(/^date: +(.+)/).first.first

        [revision, date]
      end
    end
  end
end
