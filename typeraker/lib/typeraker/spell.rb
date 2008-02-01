module Typeraker
  class Spell
    def self.check
      source_files = Dir["#{Typeraker.options[:source_dir]}/*.tex"]
      source_files.delete(File.join(Typeraker.options[:source_dir],
                                    Typeraker.options[:base_latex_file]))

      dictionary_path = File.join(Typeraker.options[:spell_dir],
                                  Typeraker.options[:spell_file])
      source_files.each do |file|
        system "ispell -t -x -p #{dictionary_path} #{file}"
      end
    end
  end
end
