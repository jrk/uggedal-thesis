module Typeraker
  class Options
    class << self
      def defaults
        root_dir         = Dir.pwd
        source_dir       = root_dir + '/src'
        build_dir        = root_dir + '/tmp'
        distribution_dir = root_dir + '/dist'
        template_file    = root_dir + '/template.erb'
        base_file        = source_dir + '/base'

        @defaults ||= {
          :root_dir         => root_dir,
          :source_dir       => source_dir,
          :build_dir        => build_dir,
          :distribution_dir => distribution_dir,
          :template_file    => template_file,
          :base_file        => base_file
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
        defaults.merge(preferences)
      end
    end
  end
end
