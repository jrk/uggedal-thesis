module Typeraker
  class Spell
    def self.check
      source_files = FileList["#{Typeraker.options[:source_dir]}/*.tex"]
      dictionary_path = File.join(Typeraker.options[:spell_dir],
                                  Typeraker.options[:spell_file])
      puts dictionary_path
      source_files.each do |file|
        file_path = File.join(Typeraker.options[:source_dir], file)
        system "ispell -t -x -p #{dictionary_path} #{file_path}"
      end
    end
  end
end
