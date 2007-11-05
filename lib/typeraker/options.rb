module Typeraker
  class Options
    class << self
      def defaults
        root_dir         = Dir.pwd
        source_dir       = root_dir + '/src'
        build_dir        = root_dir + '/tmp'
        distribution_dir = root_dir + '/dist'
        template_file    = root_dir + '/template.erb'
        base_file_path   = source_dir + '/base'

        @defaults ||= {
          :root_dir         => root_dir,
          :source_dir       => source_dir,
          :build_dir        => build_dir,
          :distribution_dir => distribution_dir,
          :template_file    => template_file,
          :base_file_path   => base_file_path,
          :base_file        => File.basename(base_file_path)
        }
      end

      # Fetching options from a config file if present and merges it
      # with the defaults.
      def setup
        preference_file = "#{defaults[:root_dir]}/config.yml"
        preferences = {}
        if File.exists? preference_file
          require 'yaml'
          File.open(preference_file) { |file| preferences = YAML.load(file) }
        end
        base_file_variations(defaults.merge(preferences))
      end

      def base_file_variations(options)
        options[:base_latex_file]  = options[:base_file] + '.tex'
        options[:base_bibtex_file] = options[:base_file] + '.aux'
        options[:base_dvi_file]    = options[:base_file] + '.dvi'
        options[:base_ps_file]     = options[:base_file] + '.ps'
        options[:base_pdf_file]    = options[:base_file] + '.pdf'
        options
      end
    end
  end
end
