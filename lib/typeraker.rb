$:.unshift(File.dirname(__FILE__))

require 'typeraker/options'

%w(config cli scm template runner builder viewer).each do |lib|
  require "typeraker/#{lib}"
end
