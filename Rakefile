SRC_DIR = File.expand_path(pwd + '/src')
BASE_NAME = 'base'
PROJECT_NAME = File.basename(pwd)
TMP_FILES = %w(aux bbl blg log lot lof toc)
GEN_FILES = %w(dvi ps pdf)

task :default => 'compile:dvi'

desc 'Compiles source files with latex and bibtex'
task :compile do
  cd(SRC_DIR) do
    out_file = File.join(SRC_DIR, "#{BASE_NAME}_out.tex")
    base_file = File.join(SRC_DIR, "#{BASE_NAME}.tex")
    File.open(out_file, 'w') do |file|
      file.write substitute_with_scm_info(base_file)
    end

    system "latex #{BASE_NAME}_out"
    if FileList['*.bib'].size > 0
      system "bibtex #{BASE_NAME}_out"
      system "latex #{BASE_NAME}_out"
    end
    system "latex #{BASE_NAME}_out"
  end
end

namespace :compile do

  desc 'Compiles source files into dvi format'
  task :dvi => :compile do
    mv_file(:dvi)
  end

  desc 'Compiles source files into ps format'
  task :ps => :compile do
    cd(SRC_DIR) do
      system "dvips #{BASE_NAME}_out"
    end
    mv_file(:ps)
  end

  desc 'Compiles source files into pdf format'
  task :pdf => :compile do
    cd(SRC_DIR) do
      system "pdflatex #{BASE_NAME}_out"
    end
    mv_file(:pdf)
  end
end

desc 'View compiled file'
task :view => 'view:dvi'

namespace :view do

  desc 'View compiled file in dvi format'
  task :dvi => 'compile:dvi'do
    view_file(:dvi)
  end

  desc 'View compiled file in ps format'
  task :ps => 'compile:ps' do
    view_file(:ps)
  end

  desc 'View compiled file in pdf format'
  task :pdf => 'compile:pdf' do
    view_file(:pdf)
  end
end

desc 'Spell check source files'
task :spell do
  # TODO: use ispell -t
end

desc 'Generate a statistical report'
task :report do
  print_stat_splitter
  print_stat_line([camelize(PROJECT_NAME), 'Total', 'Textual', '%'])
  print_stat_splitter
  section_stats = print_stat_for_sections(input_files_in_sections)
  print_stat_splitter
  print_stat_totals(section_stats)
  print_stat_splitter
end

desc 'Cleans up temporary files in source directory'
task :clean do
  cd(SRC_DIR) do
    auxilary_files = TMP_FILES + GEN_FILES
    auxilary_files.each do |tmp_file|
      rm_f FileList["*.#{tmp_file}"]
    end
  end
end

desc 'Cleans up explicitly created files in base directory'
task :clobber => :clean do
  GEN_FILES.each do |gen_file|
    rm_f FileList["#{PROJECT_NAME}.#{gen_file}"]
  end
end

private

  # Substitutes a placeholder comment in a given file with
  # SCM info like revision and date.
  def substitute_with_scm_info(file)
    scm_info = `hg tip`
    scm_rev = scm_info.grep(/changeset/).first.gsub(/[a-z]+:/, '').strip
    scm_date = scm_info.grep(/date/).first.gsub(/[a-z]+:/, '').
                                     gsub(/:\d\d \d{4} \+\d{4}/,'').strip
    formatted_info = "SCM Revision: \\texttt{#{scm_rev}}\\\\\\ \n" +
                     "SCM Date: \\texttt{#{scm_date}}"
    File.read(file).gsub(/% SCM stats/, formatted_info)
  end

  # Moves a base file in the source directory of the given format to the base
  # directory, renaming it to use the project file name. Also deletes the
  # temporary generated out latex file.
  def mv_file(format)
    mv(File.join(SRC_DIR, "#{BASE_NAME}_out.#{format.to_s}"),
       File.join(pwd, "/#{PROJECT_NAME}.#{format.to_s}"))
    rm File.join(SRC_DIR, "#{BASE_NAME}_out.tex")
  end

  # Opens up a compiled file of the given format in an appropriate viewer.
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
        system "#{viewer} #{PROJECT_NAME}.#{format.to_s}"
        return
      end
    end
  end

  def print_stat_line(stat_line)
    stats = stat_line.dup
    stats << to_percent(stats[1], stats[2]) if stats[1].instance_of? Fixnum
    puts "| #{stats.shift.ljust(30)}" +
         stats.collect { |s| "|#{s.to_s.rjust(8)} " }.join + "|"
  end

  def print_stat_splitter
    puts '+' + '-'*22 + ('-'*9 + '+') * 4
  end

  def print_stat_for_sections(section_names)
    sections = stats_for_sections(section_names)
    sections.each_value do |section|
      section.each do |stat|
        print_stat_line(stat)
      end
    end
  end

  def print_stat_totals(sections)
    total_stats =  sections.collect do |name, stats|
      [camelize(name)] + summarize_stats(stats)
    end
    total_stats << ['Totals'] + summarize_stats(total_stats)
    total_stats.each do |total_stat|
      print_stat_line(total_stat)
    end
  end

  def stats_for_sections(sections)
    stats = {}
    sections.each do |name, files|
      stats[name] = []
      files.each_with_index do |file, index|
        title = "#{camelize(name)[0..0]}.#{index+1}: #{camelize(file)}"
        file_path = File.join(SRC_DIR, "#{file}.tex")
        stats[name] << [title] + full_and_textual_wc(file_path)
      end
    end
    stats
  end

  # Finds all input files in the base source file and seperates them into
  # sections (currently: chapters, appendices).
  def input_files_in_sections
    sections = { :chapters => [], :appendices => [] }

    base_file = File.join(SRC_DIR, "#{BASE_NAME}.tex")
    File.open(base_file) do |file|
      section = :none
      file.each do |line|
        unless section == :none
          search = line.scan(/include\{([\w.]+)\}/)
          if search && search.first && search.first.first
            sections[section] << search.first.first
          end
        end
        case line
        when /\\mainmatter/
          section = :chapters
        when /\\begin\{appendices\}/
          section = :appendices
        end
      end
    end
    sections
  end
 
  # Calculates full and textual word count for a given latex file.
  # Bear in mind that these conts are pragmatic estimates.
  def full_and_textual_wc(file)
    full_wc, textual_wc = 0, 0
    File.open(file) do |f|
      f.each do |l|
        full_wc += l.split.size
        unless l.lstrip =~ /^%/         # don't count comments
          l.gsub!(/\\\w+/, '')          # strip latex commands
          l.gsub!(/\[[\w,]+\]/, '')     # strip latex command options
          l.gsub!(/\{[\w,.:_-]+\}/, '') # strip latex command parameters
          l.gsub!(/&/, '')              # strip latex column seperator
          l.gsub!(/\\\\/, '')           # strip latex implicit line break
          textual_wc += l.split.size
        end
      end
    end
    [full_wc, textual_wc]
  end

  def summarize_stats(stats)
    total, textual = 0, 0
    stats.each do |stat|
      total += stat[1]
      textual += stat[2]
    end
    [total, textual]
  end

  def to_percent(major, minor)
    major != 0 ? (100 * minor / major).round : 0
  end

  def camelize(val)
    val.to_s.split('.').collect { |s| s[0..0].upcase + s[1..-1] }.join(' ')
  end
