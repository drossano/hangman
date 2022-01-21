require "./lib/game.rb"
require "./lib/save_and_load.rb"
require "./lib/word_picker.rb"

include SaveAndLoad
serialized_file = "./saved_games/saved_game.yaml"
if File.exist?(serialized_file)
  puts "A saved game is detected. Would you like to resume it?"
  response = gets.chomp
  if response == "y"
    p saved_game = load_game
    saved_game.play_game
    File.delete(serialized_file)
  elsif response == "n"
    Game.new.play_game
  end
else
  Game.new.play_game
end