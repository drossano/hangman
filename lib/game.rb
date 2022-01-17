require_relative 'word_picker.rb'
require "pry-byebug"
class Game
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
    puts prompt = "Enter a letter that you would like to guess or enter \"save\" if you would like to save you game."
    guess = gets.chomp.downcase
    loop do
      if @incorrect_letters.include?(guess)
        puts "You have already guessed this letter."
        puts prompt
        guess = gets.chomp.downcase
      elsif guess.match?(/[a-z]/) && guess.length == 1
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

  def corect_guess(guess)
    indices = @word_array.each_index.find_all{ |i| downcase_word_array[i] == guess}
    indices.each{ |i| @dashes[i] = @word_array[i]}
  end

  def downcase_word_array
    @word_array.map { |i| i.downcase }
  end

  def play_game
    while @incorrect_guesses_remaining > 0 && @dashes != @word_array
      draw_board
      guess = player_guess
      if downcase_word_array.include?(guess)
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

Game.new.play_game
