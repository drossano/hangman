class WordPicker
  attr_reader :word
  def initialize
    @dictionary = IO.new(IO.sysopen 'dictionary.txt')
    @word_list = Array.new
    @word = create_word_list.sample
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