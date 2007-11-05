$:.unshift(File.dirname(__FILE__))

module Typeraker
  autoload :Options,  'typeraker/options'
  autoload :Cli,      'typeraker/cli'
  autoload :Config,   'typeraker/config'
  autoload :Scm,      'typeraker/scm'
  autoload :Template, 'typeraker/template'
  autoload :Runner,   'typeraker/runner'
  autoload :Builder,  'typeraker/builder'
  autoload :Viewer,   'typeraker/viewer'
  autoload :Spell,    'typeraker/spell'

  # Setting up an options accessor.
  def self.options
    @@options ||= Typeraker::Options.setup
  end
end
