module Rubbr

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module Scm
    class Base
      include Rubbr::Cli

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

    def self.stats(dir)
      if File.exists? File.join(dir, '.svn')
        Rubbr::Scm::Subversion.new.collect_scm_stats
      elsif File.exists? File.join(dir, '.hg')
        Rubbr::Scm::Mercurial.new.collect_scm_stats
      end
    end

    %w(mercurial subversion).each do
      |f| require File.dirname(__FILE__) + "/scm/#{f}"
    end
  end
end
