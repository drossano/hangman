require_relative 'game.rb'

class GameBoard
  attr_accessor :dashes
  def initialize
    @dashes = Array.new(Game.word.length, "_").join(" ")
  end
end