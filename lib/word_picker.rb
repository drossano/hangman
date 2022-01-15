class WordPicker
  def initialize
    IO.sysopen 'dictionary.txt'
    @dictionary = IO.new(5)
  end
end

WordPicker.new