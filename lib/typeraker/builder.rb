module Typeraker

  # Handles the business of building latex (and bibtex if needed) source
  # files into binary formats as dvi, ps, and pdf. The latex and bibtex
  # utilites need to be run a certain number of times so that things like
  # table of contents, references, citations, etc become proper. This module
  # tries to solve this issue by running the needed utilities only as many
  # times as needed.
  module Builder
    class Base
      include Typeraker::Cli

      # List of source files that are part of the build. If such a list is
      # present all files are verified of existence before the process
      # proceeds.
      attr_accessor :source_files

      def initialize
        @build_name = 'base'
      end

      def build_dir
        prepare_dir(Typeraker.options[:build_dir]) do
          yield
        end
      end

      def distribute_file(base_file, distribution_file)
        prepare_dir(Typeraker.options[:distribution_dir]) do
          cp(File.join(Typeraker.options[:build_dir],
                       "#{base_file.gsub(/.\w+$/, '')}.#@build_name"),
             File.join(Typeraker.options[:distribution_dir],
                       "#{distribution_file}.#@build_name"))
        end
      end

      def prepare_dir(dir)
        if dir
          mkdir_p dir unless File.exists? dir
          cd dir do
            yield
          end
        else
          yield
        end
      end
    end
  end
end

%w(dvi ps pdf).each { |f| require File.dirname(__FILE__) + "/builder/#{f}" }
