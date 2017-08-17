class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @filename = filename
    contents = File.read(filename).downcase.gsub("--", " ")
    @contents = contents.gsub(/[^a-z0-9\s]/i, "")
    @words = @contents.split(" ") - STOP_WORDS
    frequencies
    top_words(3)
  end

  def frequency(word)
    if frequencies.has_key?(word)
      frequencies[word]
    else
      0
    end
  end

  def frequencies
    @words_frequency = @words.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1  }.sort_by { |word, frequency| frequency }.reverse.to_h
    # @words_frequency = Hash.new(0).tap { |h| @words.each { |word| h[word] += 1 } }.sort_by { |word, frequency| frequency }.reverse.to_h
    @words_frequency
  end

  def top_words(number)
    @words_frequency.take(number)
  end

  def print_report
    report_words = @words_frequency.take(10).to_h

    report_words.each { |word_info|
      spaces = " "
      astericks = "*"
      num_spaces = 6 - word_info[0].length
      num_spaces.times { spaces += " " }
      word_info[1].times { astericks += "*"}
      p "#{spaces} #{word_info[0]} | #{word_info[1]} #{astericks}"}
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
