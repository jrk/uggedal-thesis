require 'optparse'
$:.unshift File.dirname(__FILE__)

module Rubbr
  autoload :Options,       'rubbr/options'
  autoload :VERSION,       'rubbr/version'
  autoload :Cli,           'rubbr/cli'
  autoload :Config,        'rubbr/config'
  autoload :Scm,           'rubbr/scm'
  autoload :Template,      'rubbr/template'
  autoload :Runner,        'rubbr/runner'
  autoload :Builder,       'rubbr/builder'
  autoload :Viewer,        'rubbr/viewer'
  autoload :Spell,         'rubbr/spell'

  class << self
    # Setting up an options accessor.
    def options
      @@options ||= Rubbr::Options.setup
    end

    def run(args = ARGV)
      options = {}

      opts = OptionParser.new do |opts|
        opts.version = Rubbr::VERSION
        opts.banner = 'Usage: rubbr [options]'

        opts.on('-f', '--format [FORMAT]', [:dvi, :ps, :pdf],
          'Select output format (dvi, ps, pdf)') do |format|
          options[:format] = format
        end

        opts.on('-v', '--view', 'View the document') do
          options[:view] = true
        end

        opts.on('-s', '--spell', 'Spell check source files') do
          options[:spell] = true
        end

        opts.on('-h', '--help', 'Show this help message') do
          puts opts
          exit 1
        end
      end

      begin
        opts.parse!(args)
      rescue OptionParser::ParseError
        puts opts
        exit 1
      end

      if options[:spell]
        spell
      elsif options[:view]
        view(options[:format])
      else
        build(options[:format])
      end
    end

    private

      def build(format)
        Rubbr::Builder.build(format)
      end

      def view(format)
        build(format)
        Rubbr::Viewer.view(format)
      end

      def spell
        Rubbr::Spell.check
      end
  end
end
