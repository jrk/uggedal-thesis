module Typeraker
  
  # Options for typeraker projects. Not to be confused with template
  # configuration/options.
  class Options
    class << self
      def defaults
        @defaults ||= {
          :root_dir         => Dir.pwd,
          :source_dir       => 'src',
          :build_dir        => 'build',
          :distribution_dir => 'dist',
          :base_file        => 'base'
        }
      end

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

  # Setting up a config accessor on the top-level module.
  def self.options
    @@options ||= Typeraker::Options.setup
  end
end
