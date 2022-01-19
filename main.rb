require "./lib/game.rb"
require "./lib/save_and_load.rb"
require "./lib/word_picker.rb"

save_and_load = SaveAndLoad.new
if save_and_load.check_for_file
  puts "A saved game is detected. Would you like to resume it?"
  response = gets.chomp
  if response == "y"
    p saved_game = save_and_load.load_game
    saved_game.play_game
  elsif response == "n"
    Game.new.play_game
  end
else
  Game.new.play_game
end