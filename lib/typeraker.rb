$:.unshift(File.dirname(__FILE__))

%w(config cli scm template runner builder viewer).each do |lib|
  require "typeraker/#{lib}"
end
