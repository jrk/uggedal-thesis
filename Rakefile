SRC_DIR = File.expand_path(File.dirname(__FILE__) + '/src')
BASE_FILE = 'base'
TMP_FILES = %w(aux bbl blg log lot lof toc)
GEN_FILES = %w(dvi ps pdf)

task :default => :compile

desc 'Compiles source files with latex and bibtex'
task :compile do
  cd(SRC_DIR) do
    system "latex #{BASE_FILE}"
    if FileList['*.bib'].size > 0
      system "bibtex #{BASE_FILE}"
      system "latex #{BASE_FILE}"
    end
    system "latex #{BASE_FILE}"
  end
end

task :view => 'view:dvi'

namespace :view do

  desc 'Compiles source files into dvi format'
  task :dvi => :compile do
    view_file(:dvi)
  end

  desc 'Compiles source files into ps format'
  task :ps => :compile do
    cd(SRC_DIR) do
      system "dvips #{BASE_FILE}"
    end
    view_file(:ps)
  end

  desc 'Compiles source files into pdf format'
  task :pdf => :compile do
    cd(SRC_DIR) do
      system "pdflatex #{BASE_FILE}"
    end
    view_file(:pdf)
  end
end

desc 'Runs spell check on source files'
task :spell do
  # TODO: use ispell -t
end

desc 'Generates a statistical report'
task :report do
  # TODO: word count: total, per chapter, with and without appendix
end

desc "Cleans up temporary files (#{TMP_FILES.join(' ')})"
task :clean do
  cd(SRC_DIR) do
    TMP_FILES.each do |tmp_file|
      rm_f FileList["*.#{tmp_file}"]
    end
  end
end

desc "Cleans up explicitly created files (#{GEN_FILES.join(' ')})"
task :clobber => :clean do
  cd(SRC_DIR) do
    GEN_FILES.each do |gen_file|
      rm_f FileList["#{BASE_FILE}.#{gen_file}"]
    end
  end
end

private
  def view_file(format)
    viewers = case format
              when :dvi
                %w(dviprog xdvi)
              when :ps
                %w(psprog evince acroread)
              when :pdf
                %w(kpdf evince acroread)
              end
    viewers.each do |viewer|
      if system "which #{viewer}"
        system "#{viewer} #{File.join(SRC_DIR, BASE_FILE)}.#{format.to_s}"
        return
      end
    end
  end
