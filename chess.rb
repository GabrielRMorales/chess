require_relative "board.rb"
require_relative "king.rb"

class Chess
#attr_accessor :board, :king
def initialize
  @board=Board.new
  @king=King.new
end

def display_board
  @board.grid << @king.symbol
  puts @board.grid
end

def a_test
  @board.grid="nothing"
  puts @board.grid
end

end

game=Chess.new
game.display_board
game.a_test