#require_relative "board.rb"

class Rook

attr_accessor :pos, :sym, :moves, :board, :opposition_pieces, :own_pieces

def initialize(pos, sym, board)
@pos=pos
@sym=sym
@board=board
#set potential moves here
#normally there are no opening moves to make for rook
@moves=[]
end

def move
	puts "Where would you like to move this rook? Enter the coords as a 2-digit number"
	new_pos=gets.chomp
	x=new_pos[0].to_i
	y=new_pos[1].to_i
	if @moves.include? ([x,y])
	  board[x][y]=self.sym
	  board[self.pos[0]][self.pos[1]]="__"
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

def find_left_moves
	x=self.pos[0]
	y=self.pos[1]-1
	while y!=-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      y-=1		
	end
end

#refactor this later
def find_right_moves
	x=self.pos[0]
	y=self.pos[1]+1
	while y!=8 && board[x][y]!=nil do
	  @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false	    
      y+=1		
	end
end

def find_vertical_up_moves
	x=self.pos[0]-1
	y=self.pos[1]
	while x!=-1 && board[x][y]!=nil do
	  @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false       
      x-=1		
	end
	
end

def find_vertical_down_moves
	x=self.pos[0]+1
	y=self.pos[1]
	while x!=8 && board[x][y]!=nil do
	  @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false     
      x+=1		
	end
end

end