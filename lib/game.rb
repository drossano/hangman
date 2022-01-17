require_relative 'word_picker.rb'
require "pry-byebug"
class Game
  def initialize
    word_picker = WordPicker.new
    @word = word_picker.word
    @word_array = word_picker.word_array
    @incorrect_guesses_remaining = 6
    @incorrect_letters = []
    puts @word
  end

  def draw_dashes(word)
    Array.new(word.length, "_").join(" ")
  end

  def draw_board
    puts draw_dashes(@word)
    puts "#{@incorrect_guesses_remaining} incorrect guesses remaining"
    unless @incorrect_letters.empty?
      puts "Inorrect Guesses:"
      p @incorrect_letters
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

  def play_game
    #inding.pry
    while @incorrect_guesses_remaining > 0
      draw_board
      guess = player_guess
      if @word_array.include?(guess)
        puts "You guessed a letter right"
      else
        puts "You guessed an incorrect letter"
        @incorrect_guesses_remaining -= 1
        collect_incorect_letters(guess)
      end
    end
    puts "You ran out of chances, game over" if @incorrect_guesses_remaining == 0
  end

  def collect_incorect_letters(incorrect_guess)
    @incorrect_letters.push(incorrect_guess)
  end
end

Game.new.play_game
