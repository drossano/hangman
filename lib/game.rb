require_relative 'word_picker.rb'
class Game
  def initialize
    @word = WordPicker.new.word
  end

  def draw_dashes
    dashes = Array.new(@word.length, "_").join(" ")
  end
end

Game.new.draw_dashes