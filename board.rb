
class Board

attr_accessor :grid

def initialize	
  #set up white side
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
 @grid=[
 		[@kingb=King.new,"__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		["__","__","__","__","__","__","__","__"],
 		]
end


end