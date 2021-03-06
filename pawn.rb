require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"

class Pawn

attr_accessor :pos, :sym, :moves, :board, :opposition_pieces, :is_white, :first_turn

def initialize(pos, sym, board, is_white)
@pos=pos
@sym=sym
@board=board
@is_white=is_white
@first_turn=true
end

def move(opposition_pieces)
	@opposition_pieces=opposition_pieces
	#resets moves after each move
	@moves=[]
	@is_white==true ? move_white : move_black
	@first_turn=false
end

def move_white	
	x=self.pos[0]-1
	y=self.pos[1]
	@moves << [x-1,y] if @first_turn==true && board[x][y+1]=="___"
    @moves << [x,y] if board[x][y]=="___"
    @moves << [x,y+1] if @opposition_pieces.include? (board[x][y+1])
    @moves << [x,y-1] if @opposition_pieces.include? (board[x][y-1])
	puts "moves: #{@moves}"	
	puts "Where would you like to move this pawn? Enter the coords as a 2-digit number"
	new_pos=gets.chomp
	x=new_pos[0].to_i
	y=new_pos[1].to_i	
	  if @moves.include? ([x,y])
	  	board[x][y]=self.sym
	    board[self.pos[0]][self.pos[1]]="___"
	    self.pos=[x,y]
	  else	 
	    move_white
	  end
end

def move_black
	x=self.pos[0]+1
	y=self.pos[1]
	@moves << [x+1,y] if @first_turn==true && board[x][y+1]=="___"	
    @moves << [x,y] if board[x][y]=="___"
    @moves << [x,y+1] if @opposition_pieces.include? (board[x][y+1])
    @moves << [x,y-1] if @opposition_pieces.include? (board[x][y-1])
	puts "moves: #{@moves}"
	puts "Where would you like to move this pawn? Enter the coords as a 2-digit number"
	new_pos=gets.chomp
	x=new_pos[0].to_i
	y=new_pos[1].to_i	
	if @moves.include? ([x,y])
	  board[x][y]=self.sym
	  board[self.pos[0]][self.pos[1]]="___"
	  self.pos=[x,y]
	else	 
	  move_black
	end
end

def get_moves
	@moves
end

def get_pos
	@pos
end

end