class Knight

attr_accessor :pos, :sym, :moves, :board, :own_pieces

def initialize(pos, sym, board)
@pos=pos
@sym=sym
@board=board
@moves=[]
end

def move
	puts "Where would you like to move this knight? Enter the coords as a 2-digit number"
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
	y=self.pos[1]
    @moves << [x+1,y+2] if x+1<8 && y+2<8 && (@own_pieces.include? (board[x+1][y+2])) ==false
    @moves << [x+1,y-2] if x+1<8 && y-2>=0 && (@own_pieces.include? (board[x+1][y-2])) ==false

    @moves << [x+2,y+1] if x+2<8 && y+1<8 && (@own_pieces.include? (board[x+2][y+1])) ==false 
    @moves << [x+2,y-1] if x+2<8 && y-1>=0 && (@own_pieces.include? (board[x+2][y-1])) ==false 

    @moves << [x-1,y+2] if x-1>=0 && y+2<8 && (@own_pieces.include? (board[x-1][y+2])) ==false
    @moves << [x-1,y-2] if x-1>=0 && y-2>=0 && (@own_pieces.include? (board[x-1][y-2])) ==false

    @moves << [x-2,y+1] if x-2>=0 && y+1<8 && (@own_pieces.include? (board[x-2][y+1])) ==false
    @moves << [x-2,y-1] if x-2>=0 && y-1<8 && (@own_pieces.include? (board[x-2][y-1])) ==false
    
	puts "moves: #{@moves}"
end

def get_moves
	@moves
end

end