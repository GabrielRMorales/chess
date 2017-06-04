class Bishop

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
	puts "Where would you like to move this bishop? Enter the coords as a 2-digit number"
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
	find_leftup_moves
	find_rightup_moves
	find_leftdown_moves
	find_rightdown_moves
	puts "moves: #{@moves}"
end

def find_leftup_moves
	x=self.pos[0]-1
	y=self.pos[1]-1
	while x!=-1 && y!=-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x-=1
      y-=1		
	end
end

def find_rightup_moves
	x=self.pos[0]-1
	y=self.pos[1]+1
	while x!=-1 && y!=8 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x-=1
      y+=1		
	end
end

def find_rightdown_moves
	x=self.pos[0]+1
	y=self.pos[1]+1
	while x!=8 && y!=8 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x+=1
      y+=1		
	end
end

def find_leftdown_moves
	x=self.pos[0]+1
	y=self.pos[1]-1
	while x!=8 && y!=-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x+=1
      y-=1		
	end
end


end