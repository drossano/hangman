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
end