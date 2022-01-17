require_relative 'word_picker.rb'
class Game
  def initialize
    @word = WordPicker.new.word
  end

  def draw_dashes(word)
    Array.new(word.length, "_").join(" ")
  end

  def draw_board
    puts draw_dashes(@word)
    puts "#{track_incorrect_guesses} incorrect guesses remaining"
  end

  def track_incorrect_guesses
    incorrect_guesses_remaining = 6
  end

  def player_guess
    puts prompt = "Enter a letter that you would like to guess or enter \"save\" if you would like to save you game."
    guess = gets.chomp.downcase
    loop do
      if guess.match?(/[a-z]/) && guess.length == 1
        break
      elsif guess == "save"
        puts "This featrues is not yet implemented"
        puts prompt
        guess = gets.chomp.downcase
      else
        puts "Invalid guess #{prompt}"
        guess = gets.chomp.downcase
      end
    end
    guess
  end

  def play_game
    draw_board
    player_guess
  end
end

Game.new.play_game
