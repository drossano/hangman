require "yaml"
module SaveAndLoad
  def save_game(game)
    yaml = YAML::dump(game)
    saved_game = File.open("./saved_games/saved_game.yaml", "w")
    saved_game.puts yaml
    saved_game.close
    puts "Game successfully saved."
    exit
  end

  def load_game
    saved_game = File.open("./saved_games/saved_game.yaml", "r")
    yaml = saved_game.read
    puts "Loading game..."
    YAML::load(yaml)
  end

  def overwrite_check
    if File.exist?("./saved_games/saved_game.yaml")
      puts "A saved game already exists. Would you like to overwrite it? (Enter \"yes\" or \"no\")"
      response = gets.chomp.downcase
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
    else
      save_game(self)
    end
  end
end