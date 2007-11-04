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

      # The dir where the files to be built should be located.
      attr_accessor :source_dir

      # The dir where the build should be run. This dir is
      # created if it's not present.
      attr_accessor :build_dir

      # The dir where the buildt files are placed. This dir is
      # created if it's not present.
      attr_accessor :distribution_dir

      # List of source files that are part of the build. If such a list is
      # present all files are verified of existence before the process
      # proceeds.
      attr_accessor :source_files

      def initialize(build_dir, distribution_dir)
        @build_dir = build_dir
        @distribution_dir = distribution_dir

        @build_name = 'base'
      end

      def build_dir
        prepare_dir(@build_dir) do
          yield
        end
      end

      def distribute_file(base_file, distribution_file)
        prepare_dir(@distribution_dir) do
          cp(File.join(@build_dir,
                       "#{base_file.gsub(/.\w+$/, '')}.#@build_name"),
             File.join(@distribution_dir,
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

    class Dvi < Base
      def initialize(build_dir, source_dir, distribution_dir, source_files=[])
        super(build_dir, distribution_dir)
        @source_dir = source_dir
        @source_files = source_files

        @build_name = 'dvi'
      end

      def build(base_latex_file, base_bibtex_file=nil, distribution_name=nil)
        clean_build_dir
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
        distribute_file(base_latex_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_latex_file} " +
               "in #{@build_dir}"
      end

      def clean_build_dir
        rm_r @build_dir if File.exists? @build_dir
      end

      def copy_source_files
        %w(tex bib sty cls clo eps jpg).each do |file_extension|
          FileList["#{@source_dir}/*.#{file_extension}"].each do |file|
            cp(file,  @build_dir)
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

    class Ps < Base
      def initialize(*args)
        super
        @build_name = 'ps'
      end

      def build(base_dvi_file, distribution_name)
        build_dir do
          dvips = Typeraker::Runner::DviPs.new(base_dvi_file)
        end
        distribute_file(base_dvi_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_dvi_file} " +
               "in #{@build_dir}"
      end
    end

    class Pdf < Base
      def initialize(*args)
        super
        @build_name = 'pdf'
      end

      def build(base_ps_file, distribution_name)
        build_dir do
          dvips = Typeraker::Runner::Ps2Pdf.new(base_ps_file)
        end
        distribute_file(base_ps_file, distribution_name)
        notice "Build of #{@build_name} completed for: #{base_ps_file} " +
               "in #{@build_dir}"
      end
    end
  end
end
