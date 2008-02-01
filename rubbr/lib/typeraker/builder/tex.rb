module Typeraker
  module Builder
    class Tex < Base
      class << self
        def build(output_format = 'dvi')
          @output_format = output_format

          clean_build_dir

          base_latex_file = Typeraker.options[:base_latex_file]
          base_bibtex_file = Typeraker.options[:base_bibtex_file]

          if output_format == 'pdf'
            preprocessor = Typeraker::Runner::PdfLaTeX
          else
            preprocessor = Typeraker::Runner::LaTeX
          end

          build_dir do
            copy_source_files
            copy_vendor_files

            latex = preprocessor.new(base_latex_file, true)
            if base_bibtex_file && latex.warnings.join =~ /No file .+\.bbl/
              bibtex = Typeraker::Runner::BibTeX.new(base_bibtex_file, true)
            end
            if latex.warnings.join =~ /No file .+\.(aux|toc)/
              latex = preprocessor.new(base_latex_file, true)
            end
            if latex.warnings.join =~ /There were undefined citations/
              latex = preprocessor.new(base_latex_file, true)
            end
            latex.silent = false
            latex.feedback
            if bibtex
              bibtex.silent = false
              bibtex.feedback
            end
          end
          distribute_file(base_latex_file)
          notice "Build of #@output_format completed for: #{base_latex_file} " +
                 "in #{Typeraker.options[:build_dir]}"
        end

        private

          def clean_build_dir
            if File.exists? Typeraker.options[:build_dir]
              FileUtils.rm_r Typeraker.options[:build_dir]
            end
          end

          def copy_source_files
            copy_files(Typeraker.options[:source_dir], %w(tex bib cls))
          end

          def copy_vendor_files
            copy_files(Typeraker.options[:vendor_dir], %w(sty clo cls cfg))
          end

          def copy_files(source_dir, file_extensions)
            file_extensions.each do |file_extension|
              Dir["#{source_dir}/*.#{file_extension}"].each do |file|
                FileUtils.cp(file,  Typeraker.options[:build_dir])
              end
            end
          end
      end
    end
  end
end
