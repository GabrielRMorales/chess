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
#set a counter for turn 1-if its the first turn, it can move two spaces
#needs different pawns moves for black and white
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
	
	puts "moves: #{@moves}"
end

def find_forward_moves
	x=self.pos[0]
	y=self.pos[1]-1
	while y>-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      #needs this line to prevent it from going on
      y=-1 if (@own_pieces.include? (board[x][y])) ==true
      y-=1		
	end
end

end