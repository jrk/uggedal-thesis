module Typeraker
  module Builder
    class Dvi < Base
      def initialize
        @source_files = Typeraker::Configuration.collect_source_files

        @build_name = 'dvi'
      end

      def build
        clean_build_dir

        base_latex_file = Typeraker.options[:base_latex_file]
        base_bibtex_file = Typeraker.options[:base_bibtex_file]

        build_dir do
          copy_source_files
          return unless source_files_present?

          latex = Typeraker::Runner::LaTeX.new(base_latex_file, true)
          if base_bibtex_file && latex.warnings.join =~ /No file .+\.bbl/
            bibtex = Typeraker::Runner::BibTeX.new(base_bibtex_file, true)
          end
          if latex.warnings.join =~ /No file .+\.(aux|toc)/
            latex = Typeraker::Runner::LaTeX.new(base_latex_file, true)
          end
          if latex.warnings.join =~ /There were undefined citations/
            latex = Typeraker::Runner::LaTeX.new(base_latex_file, true)
          end
          latex.silent = false
          latex.feedback
          if bibtex
            bibtex.silent = false
            bibtex.feedback
          end
        end
        distribute_file(base_latex_file)
        notice "Build of #{@build_name} completed for: #{base_latex_file} " +
               "in #{Typeraker.options[:build_dir]}"
      end

      def clean_build_dir
        if File.exists? Typeraker.options[:build_dir]
          rm_r Typeraker.options[:build_dir]
        end
      end

      def copy_source_files
        source_dir = Typeraker.options[:source_dir]
        %w(tex bib sty cls clo eps jpg).each do |file_extension|
          source_dir
          FileList["#{source_dir}/*.#{file_extension}"].each do |file|
            cp(file,  Typeraker.options[:build_dir])
          end
        end
      end

      def source_files_present?
        @source_files.each do |file|
          unless File.exists? file
            error "Build of #@build_name aborted. " +
                  "Source file: #{file} not found"
            return false
          end
        end
        true
      end
    end
  end
end
