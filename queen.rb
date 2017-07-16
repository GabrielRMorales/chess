class Queen

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
	puts "Where would you like to move this queen? Enter the coords as a 2-digit number"
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
	find_leftup_moves
	find_rightup_moves
	find_leftdown_moves
	find_rightdown_moves
	puts "moves: #{@moves}"
	#@moves.each do |x|
	#	puts "King is in check" if board[x[0]][x[1]]=="K_W" || board[x[0]][x[1]]=="K_B"
	#end
end

def find_left_moves
	x=self.pos[0]
	y=self.pos[1]-1
	while y>-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      #needs this line to prevent it from going on
      y=-1 if (@own_pieces.include? (board[x][y])) ==true
      y-=1		
	end
end

#refactor this later
def find_right_moves
	x=self.pos[0]
	y=self.pos[1]+1
	while y<8 && board[x][y]!=nil do
	  @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
	  y=8 if (@own_pieces.include? (board[x][y])) ==true    
      y+=1		
	end
end

def find_vertical_up_moves
	x=self.pos[0]-1
	y=self.pos[1]
	while x>-1 && board[x][y]!=nil do
	  @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false       
      x-=1		
	end
	
end

def find_vertical_down_moves
	x=self.pos[0]+1
	y=self.pos[1]
	while x<8 && board[x][y]!=nil do
	  @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false     
      x+=1		
	end
end

def find_leftup_moves
	x=self.pos[0]-1
	y=self.pos[1]-1
	while x!>-1 && y>-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x=-1 if (@own_pieces.include? (board[x][y])) ==true
      x-=1
      y-=1		
	end
end

def find_rightup_moves
	x=self.pos[0]-1
	y=self.pos[1]+1
	while x>-1 && y<8 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x=-1 if (@own_pieces.include? (board[x][y])) ==true
      x-=1
      y+=1		
	end
end

def find_rightdown_moves
	x=self.pos[0]+1
	y=self.pos[1]+1
	while x<8 && y<8 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x=8 if (@own_pieces.include? (board[x][y])) ==true
      x+=1
      y+=1		
	end
end

def find_leftdown_moves
	x=self.pos[0]+1
	y=self.pos[1]-1
	while x<8 && y!=-1 && board[x][y]!=nil do	  
      @moves << [x,y] if (@own_pieces.include? (board[x][y])) ==false
      x=8 if (@own_pieces.include? (board[x][y])) ==true
      x+=1
      y-=1		
	end
end

def get_moves
	@moves
end

end