require "yaml"
class SaveAndLoad
  def save_game(game)
    yaml = YAML::dump(game)
    saved_game = File.open("./saved_games/saved_game.yaml", "w")
    saved_game.puts yaml
    saved_game.close
  end

  def load_game
    saved_game = File.open("./saved_games/saved_game.yaml", "r")
    yaml = saved_game.read
    YAML::load(yaml)
  end

   def check_for_file
     File.exist?("./saved_games/saved_game.yaml")
   end
end
