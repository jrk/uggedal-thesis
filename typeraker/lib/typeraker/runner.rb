module Typeraker

  # Takes care of running latex and related utilities. Gives helpful
  # information if input files are missing and also cleans up the output of
  # these utilities.
  module Runner
    class Base
      include Typeraker::Cli

      # The file to be run trough the latex process.
      attr_accessor :input_file

      # If true no messages is sendt to standard out. Defaults to false.
      attr_accessor :silent

      # The executable to be run.
      attr_accessor :executable

      # Contains a list of possible warnings after a run.
      attr_accessor :warnings

      # Contains a list of possible errors after a run.
      attr_accessor :errors

      def initialize(input_file, silent, executable)
        @input_file = input_file
        disable_stdout do
          @executable = executable if system "which #{executable}"
        end
        @silent = silent
        @errors = []

        if File.exists? @input_file
          run
        else
          error "Running of #@executable aborted. " +
                "Input file: #@input_file not found"
        end
      end

      def run
      end

      def feedback
        return if @silent
        unless @warnings.empty?
          notice "Warnings from #@executable:"
          @warnings.each do |message|
            warning message
          end
        end
        unless @errors.empty?
          notice "Errors from #@executable:"
          @errors.each do |message|
            error message
          end
        end
      end
    end

    %w(latex bibtex dvips ps2pdf).each do
      |f| require File.dirname(__FILE__) + "/runner/#{f}"
    end
  end
end
