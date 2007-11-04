module Typeraker

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module Scm
    class Base
      include Typeraker::Cli

      # The name of the SCM system. 
      attr_accessor :name

      # The Mercurial executable.
      attr_accessor :executable

      # The revision and date of the tip/head/latest changeset.
      attr_accessor :revision, :date

      def collect_scm_stats
        { :name => @name,
          :revision => @revision,
          :date => @date }
      end
    end

    class Mercurial < Base

      def initialize
        super

        @name = 'Mercurial'
        disable_stdout do
          @executable = 'hg' if system 'which hg'
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

    class Subversion < Base

      def initialize
        super

        @name = 'Subversion'
        disable_stdout do
          @executable = 'svn' if system 'which svn'
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
