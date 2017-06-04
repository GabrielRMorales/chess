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
	puts "Where would you like to move this King? Enter the coords as a 2-digit number"
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

def find_moves(opposition_pieces, own_pieces)
	@opposition_pieces=opposition_pieces
	@own_pieces=own_pieces
	#resets moves after each move
	@moves=[]
	find_left_moves
	find_right_moves
	find_vertical_up_moves
	find_vertical_down_moves
	puts "moves: #{@moves}"
end


end