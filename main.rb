require "./lib/game.rb"
require "./lib/save_and_load.rb"
require "./lib/word_picker.rb"

include SaveAndLoad
serialized_file = "./saved_games/saved_game.yaml"
if File.exist?(serialized_file)
  puts "A saved game is detected. Would you like to resume it? (Enter \"yes\" or \"no\")"
  response = gets.chomp.downcase
  loop do
    if response == "yes"
      saved_game = load_game
      saved_game.play_game
      File.delete(serialized_file)
      break
    elsif response == "no"
      Game.new.play_game
      break
    else
      puts "Invaled choice. Enter \"yes\" or \"no\" if you would like to resume your saved game."
      response = gets.chomp.downcase
    end
  end
else
  Game.new.play_game
end