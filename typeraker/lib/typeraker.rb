$:.unshift File.dirname(__FILE__)

module Typeraker
  autoload :Main,          'typeraker/main'
  autoload :Options,       'typeraker/options'
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

    # Returns binding that can be used in erb templates.
    def values
      binding
    end
  end
end
