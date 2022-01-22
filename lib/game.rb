require_relative 'word_picker.rb'
require_relative 'save_and_load.rb'
require "pry-byebug"
class Game
  include SaveAndLoad
  def initialize
    word_picker = WordPicker.new
    @word = word_picker.word
    @word_array = word_picker.word_array
    @incorrect_guesses_remaining = 6
    @incorrect_letters = []
    @dashes = draw_dashes(@word)
    puts @word # For testing purposes
  end

  def draw_dashes(word)
    Array.new(word.length, "_")
  end

  def draw_board
    puts @dashes.join(" ")
    puts "#{@incorrect_guesses_remaining} incorrect guesses remaining"
    unless @incorrect_letters.empty?
      puts "Inorrect Guesses:"
      puts @incorrect_letters.join(", ")
    end
  end

  def player_guess
    guess = guess_prompt
    loop do
      if @incorrect_letters.include?(guess) || downcase_array(@dashes).include?(guess)
        puts "You have already guessed this letter."
        guess = guess_prompt
      elsif guess.match?(/[a-z]/) && guess.length == 1
        break
      elsif guess == "save"
        overwrite_check
      else
        puts "Invalid guess"
        guess = guess_prompt
      end
    end
    guess
  end

  def overwrite_check
    saved_feedback = "Game successfully saved."
    if File.exist?("./saved_games/saved_game.yaml")
      puts "A saved game already exists. Would you like to overwrite it? (Enter \"yes\" or \"no\")"
      response = gets.chomp.downcase
      loop do
        if response == "yes"
          save_game(self)
          puts saved_feedback
          break
        elsif response == "no"
          play_game
          break
        else
          puts "Invaled choice. Enter \"yes\" or \"no\" if you would like to overwrite your saved game."
          response = gets.chomp.downcase
        end
      end
    else
      save_game(self)
      puts saved_feedback
    end
  end

  def downcase_array(array)
    array.map { |i| i.downcase }
  end

  def guess_prompt
    puts "Enter a letter that you would like to guess or enter \"save\" if you would like to save you game."
    gets.chomp.downcase
  end

  def corect_guess(guess)
    indices = @word_array.each_index.find_all{ |i| downcase_array(@word_array)[i] == guess}
    indices.each{ |i| @dashes[i] = @word_array[i]}
  end

  def play_game
    while @incorrect_guesses_remaining > 0 && @dashes != @word_array
      draw_board
      guess = player_guess
      if downcase_array(@word_array).include?(guess)
        puts "You guessed a letter right"
        corect_guess(guess)
      else
        puts "You guessed an incorrect letter"
        @incorrect_guesses_remaining -= 1
        collect_incorect_letters(guess)
      end
    end
    draw_board
    puts "You ran out of chances, game over" if @incorrect_guesses_remaining == 0
    puts "You got the word right!" if @dashes == @word_array
  end

  def collect_incorect_letters(incorrect_guess)
    @incorrect_letters.push(incorrect_guess)
  end
end