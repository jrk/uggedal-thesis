module Typeraker

  # Handles command line output and input.
  module Cli
    def notice(message)
      puts message
    end

    def warning(message)
      puts "  - #{message}"
    end

    def error(message)
      puts "  * #{message}"
    end

    def disable_stdout
      old_stdout = STDOUT.dup
      STDOUT.reopen('/dev/null')
      yield
      STDOUT.reopen(old_stdout)
    end

    def disable_stderr
      old_stderr = STDERR.dup
      STDERR.reopen('/dev/null')
      yield
      STDERR.reopen(old_stderr)
    end

    def disable_stdinn
      old_stdinn = STDIN.dup
      STDIN.reopen('/dev/null')
      yield
      STDIN.reopen(old_stdinn)
    end
  end
end
