class WordPicker
  attr_accessor :word, :word_array
  def initialize
    @dictionary = IO.new(IO.sysopen 'dictionary.txt')
    @word_list = Array.new
    @word = pick_word(create_word_list)
    @word_array = make_word_array(@word.downcase)
  end

  def pick_word(word_list)
    word_list.sample
  end

  def make_word_array(word)
    word.chars
  end
  
  def create_word_list
      until @dictionary.eof? == true do
        word = @dictionary.gets.chomp
        if word.length >= 5 && word.length <= 12
          @word_list.push word
        end
      end
      @word_list
  end
end