#require_relative "board.rb"
class King

attr_accessor :pos, :sym, :moves, :board, :opposition_pieces, :own_pieces

def initialize(pos, sym, board)
@pos=pos
@sym=sym
@board=board
#set potential moves here
#normally there are no opening moves to make for King
@moves=[]
end

#change the move/find_moves methods to check against possible checks-essentially it cannot move
#into a move included in the black/white moves hash in the chess.rb
def move
	puts "Where would you like to move this king? Enter the coords as a 2-digit number"
	new_pos=gets.chomp
	x=new_pos[0].to_i
	y=new_pos[1].to_i
	if @moves.include? ([x,y])
	  board[x][y]=self.sym
	  board[self.pos[0]][self.pos[1]]="___"
	  self.pos=[x,y]
	else	 
	  move
	end
end

def find_moves(own_pieces)
	@own_pieces=own_pieces
	#resets moves after each move
	@moves=[]
	x=self.pos[0]
	y=self.pos[1]-1
	while y>-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      #needs this line to prevent it from going on
      y=-1 if (@own_pieces.include? (board[x][y])) ==true
      y-=1		
	end
	puts "moves: #{@moves}"

end