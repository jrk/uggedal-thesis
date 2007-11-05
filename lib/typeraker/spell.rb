module Typeraker
  class Spell
      # List of source files that are slated for spell checking.
      attr_accessor :source_files

    def initialize(source_files)
      @source_files = source_files

      spell_check
    end

    def spell_check
      dictionary_path = File.join(Typeraker.options[:source_dir],
                                  'dictionary.ispell')
      @source_files.each do |file|
        file_path = File.join(Typeraker.options[:source_dir], file)
        system "ispell -t -p #{dictionary_path} #{file_path}"
      end
    end
  end
end
