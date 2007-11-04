module Typeraker

  # Provides a template for a base latex file. This template can be configured
  # quite extencively by changing many of the class' instance variables. This
  # can easily be done with a block:
  #
  #   Typeraker::Template.new('Dev Null and Nothingness') do |t|
  #     t.klass = { :book => %w(12pt a4paper twoside) }
  #
  #     t.packages << { :fontenc => ['T1'] }
  #     t.packages << { :natbib => [] }
  #
  #     t.author = { :name => 'Eivind Uggedal', :email => 'eu@redflavor.com' }
  #
  #     t.table_of_contents = true
  #
  #     t.main_content = %w(introduction previous.research method data)
  #
  #     t.appendices = %w(data.tables concent.forms)
  #   end
  #
  class BaseTemplate
    require 'erb'
    include Typeraker::Cli

    attr_reader :config

    def initialize(config)
      @config = config
    end

    def create_file
      base_path = File.join(@config.source_dir, @config.base_latex_file)
      File.open(base_path, 'w') do |f|
        f.puts generate
      end
      notice "Creation completed for: #{@config.base_latex_file} in " +
             "#{@config.source_dir}"
    end

    def generate
      ERB.new(template, 0, '%<>').result(@config.values)
    end

    def template
      if @config.base_template_file
        File.read @config.base_template_file
      else
        error "Missing base template file"
      end
    end
  end
end
