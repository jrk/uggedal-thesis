module Typeraker
  class Spell
    def self.check
      source_files = Typeraker::Configuration.collect_source_files.grep(/\.tex$/)
      dictionary_path = File.join(Typeraker.options[:spell_dir],
                                  Typeraker.options[:spell_file])
      puts dictionary_path
      source_files.each do |file|
        file_path = File.join(Typeraker.options[:source_dir], file)
        system "ispell -t -p #{dictionary_path} #{file_path}"
      end
    end
  end
end
