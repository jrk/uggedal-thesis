$:.unshift File.dirname(__FILE__)

module Typeraker
  autoload :Options,       'typeraker/options'
  autoload :Configuration, 'typeraker/configuration'
  autoload :Cli,           'typeraker/cli'
  autoload :Config,        'typeraker/config'
  autoload :Scm,           'typeraker/scm'
  autoload :Template,      'typeraker/template'
  autoload :Runner,        'typeraker/runner'
  autoload :Builder,       'typeraker/builder'
  autoload :Viewer,        'typeraker/viewer'
  autoload :Spell,         'typeraker/spell'

  class << self
    # Setting up an options accessor.
    def options
      @@options ||= Typeraker::Options.setup
    end

    # Setting up an configuration accessor.
    def config
      @@configurations ||= Typeraker::Configuration.setup
    end

    # Returns binding that can be used in erb templates.
    def values
      binding
    end
  end
end
