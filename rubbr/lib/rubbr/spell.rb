module Rubbr
  class Spell
    def self.check
      source_files = Dir["#{Rubbr.options[:source_dir]}/*.tex"]
      source_files.delete(File.join(Rubbr.options[:source_dir],
                                    Rubbr.options[:base_latex_file]))

      dictionary_path = File.join(Rubbr.options[:spell_dir],
                                  Rubbr.options[:spell_file])
      source_files.each do |file|
        system "ispell -t -x -p #{dictionary_path} #{file}"
      end
    end
  end
end
