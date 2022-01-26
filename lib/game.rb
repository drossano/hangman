require_relative 'word_picker.rb'
require_relative 'save_and_load.rb'

class Game
  include SaveAndLoad
  def initialize
    word_picker = WordPicker.new
    @word = word_picker.word
    @word_array = word_picker.word_array
    @incorrect_guesses_remaining = 6
    @incorrect_letters = []
    @dashes = draw_dashes(@word)
  end

  def draw_dashes(word)
    Array.new(word.length, "_")
  end

  def draw_board
    puts @dashes.join(" ")
    puts "#{@incorrect_guesses_remaining} incorrect guess#{check_incorrect_guess_plurality} remaining"
    puts "Inorrect Guesses: \n#{@incorrect_letters.join(", ")}" unless @incorrect_letters.empty?
  end

  def check_incorrect_guess_plurality
    "es" if @incorrect_guesses_remaining != 1
  end

  def validate_guess_input(guess)
    if @incorrect_letters.include?(guess) || downcase_array(@dashes).include?(guess)
      previously_guessed
    elsif guess.match?(/[a-z]/) && guess.length == 1
      check_guess(guess)
    elsif guess == "save"
      overwrite_check
    else
      invalid_guess
    end
  end

  def previously_guessed
    puts "You have already guessed this letter."
    guess_prompt
  end

  def invalid_guess
    puts "Invalid guess"
    guess_prompt
  end

  def overwrite_check
    if File.exist?("./saved_games/saved_game.yaml")
      puts "A saved game already exists. Would you like to overwrite it? (Enter \"yes\" or \"no\")"
      validate_overwrite_response(gets.chomp.downcase)
    else
      save_game(self)
    end
  end

  def validate_overwrite_response(response)
    loop do
      if response == "yes"
        save_game(self)
        break
      elsif response == "no"
        play_game
        break
      else
        puts "Invaled choice. Enter \"yes\" or \"no\" if you would like to overwrite your saved game."
        response = gets.chomp.downcase
      end
    end
  end

  def downcase_array(array)
    array.map { |i| i.downcase }
  end

  def guess_prompt
    draw_board
    puts "Enter a letter that you would like to guess or enter \"save\" if you would like to save you game."
    guess = gets.chomp.downcase
    validate_guess_input(guess)
  end

  def corect_guess(guess)
    indices = @word_array.each_index.find_all{ |i| downcase_array(@word_array)[i] == guess}
    indices.each{ |i| @dashes[i] = @word_array[i]}
  end

  def play_game
    while @incorrect_guesses_remaining > 0 && @dashes != @word_array
      guess_prompt
    end
    draw_board
    puts "You ran out of chances, game over. The word was #{@word}." if @incorrect_guesses_remaining == 0
    puts "You got the word right!" if @dashes == @word_array
  end

  def check_guess(guess)
    if downcase_array(@word_array).include?(guess)
      puts "You guessed a letter right"
      corect_guess(guess)
    else
      puts "You guessed an incorrect letter"
      @incorrect_guesses_remaining -= 1
      collect_incorect_letters(guess)
    end
  end

  def collect_incorect_letters(incorrect_guess)
    @incorrect_letters.push(incorrect_guess)
  end
end