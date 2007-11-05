module Typeraker

  # Provides a template for a base latex file.
  class Template
    class << self
      require 'erb'
      include Typeraker::Cli

      def create_file
        base_path = File.join(Typeraker.options[:source_dir],
                              Typeraker.options[:base_latex_file])
        File.open(base_path, 'w') do |f|
          f.puts generate
        end
        notice "Creation completed for: " +
               Typeraker.options[:base_latex_file] +
               " in #{Typeraker.options[:source_dir]}"
      end

      def generate
        ERB.new(template, 0, '%<>').result(Typeraker.values) if template
      end
      
      private

        def template
          if File.exists? Typeraker.options[:template_file]
            File.read Typeraker.options[:template_file]
          else
            error "Missing base template file"
          end
        end
    end
  end
end
