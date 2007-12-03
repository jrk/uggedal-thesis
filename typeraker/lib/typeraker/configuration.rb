module Typeraker
  class Configuration
    class << self
      def defaults
        @defaults ||= {
          :klass             => { :book => %w(12pt twoside)},
          :packages          => [],
          :title             => nil,
          :sub_title         => nil,
          :author            => nil,
          :date              => nil,
          :scm               => nil,
          :abstract          => nil,
          :acknowledgments   => nil,
          :table_of_contents => false,
          :list_of_figures   => false,
          :list_of_tables    => false,
          :main_content      => [],
          :appendices        => [],
          :bibliography      => {},
          :options           => Typeraker.options
        }
      end

      # Fetching options from a config file if present and merges it
      # with the defaults.
      def setup
        preference_file = "#{Typeraker.options[:root_dir]}/config.yml"
        preferences = {}
        if File.exists? preference_file
          require 'yaml'
          File.open(preference_file) { |file| preferences = YAML.load(file) }
          preferences = preferences[:template] if preferences[:template]
        end
        fetch_scm_info(defaults.merge(preferences))
      end

      def fetch_scm_info(options)
        if options[:scm]
          stats = "Typeraker::Scm::#{options[:scm]}.new.collect_scm_stats"
          options[:scm] = eval stats
        end
        options
      end

      # Returns a list of all latex and bibtex source files (main_content,
      # appendices, and bibliography) with file extension (.tex and .bib).
      def collect_source_files
        tex = Typeraker.config[:main_content] + Typeraker.config[:appendices]
        bib = Typeraker.config[:bibliography]
        
        tex.collect { |a| "#{a}.tex" } + bib.keys.collect { |a| "#{a}.bib" }
      end

      # File name prefix for distributed files.
      def distribution_name
        if Typeraker.config[:scm]
          to_file_name(Typeraker.config[:author][:name],
              Typeraker.config[:title],
              "r#{Typeraker.config[:scm][:revision].gsub(/:\w+/, '')}")
        else
          to_file_name(Typeraker.config[:author][:name],
              Typeraker.config[:title])
        end
      end

      def to_file_name(*names)
        names.collect do |name|
          name.downcase.gsub(/ /, '.').gsub(/:|-/, '')
        end.join('.')
      end
    end
  end
end
