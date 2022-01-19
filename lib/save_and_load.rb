require "yaml"
class SaveAndLoad
  def save_game(game)
    yaml = YAML::dump(game)
    saved_game = File.open("./saved_games/saved_game.yaml", "w")
    saved_game.puts yaml
    saved_game.close
  end
end
