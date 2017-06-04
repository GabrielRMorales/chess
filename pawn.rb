class Pawn

attr_accessor :pos, :sym, :moves, :board, :opposition_pieces, :own_pieces

def initialize(pos, sym, board)
@pos=pos
@sym=sym
@board=board
#set potential moves here
@moves=[]
end

#change move and find_moves accordingly-it can only move one forward, but captures diagonally forward
def move
	
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

#defaults need to change for black/white
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