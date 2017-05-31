require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
#add in serialization after

class Chess
attr_accessor :white_potential_moves, :black_potential_moves

def initialize
  #set up white side
  @board=Board.new
  @kingw=King.new
  @queenw=Queen.new
  @knightwone=Knight.new
  @bishopwone=Bishop.new
  @rookwone=Rook.new
  @knightwtwo=Knight.new
  @bishopwtwo=Bishop.new
  @rookwtwo=Rook.new

  #pawns
  @pawnwone=Pawn.new
  @pawnwtwo=Pawn.new
  @pawnwthree=Pawn.new
  @pawnwfour=Pawn.new
  @pawnwfive=Pawn.new
  @pawnwsix=Pawn.new
  @pawnwseven=Pawn.new
  @pawnweight=Pawn.new

  #set up black side
  @kingb=King.new
  @queenb=Queen.new
  @knightbone=Knight.new
  @bishopbone=Bishop.new
  @rookbone=Rook.new
  @knightbtwo=Knight.new
  @bishopbtwo=Bishop.new
  @rookbtwo=Rook.new
  #pawns
  @pawnbone=Pawn.new
  @pawnbtwo=Pawn.new
  @pawnbthree=Pawn.new
  @pawnbfour=Pawn.new
  @pawnbfive=Pawn.new
  @pawnbsix=Pawn.new
  @pawnbseven=Pawn.new
  @pawnbeight=Pawn.new
end

def display_board
  #@board.grid << @king.symbol
  @board.grid.each { |x| 
	x.each { |y|
	print y
	}
	puts ""
	}
end


end

game=Chess.new
game.display_board