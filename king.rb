#require_relative "board.rb"
class King

attr_accessor :pos, :sym, :moves, :board, :opp_moves, :own_pieces

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

def find_moves(own_pieces, opp_moves)
	@own_pieces=own_pieces
	@opp_moves=opp_moves
	#resets moves after each move
	@moves=[]
	x=self.pos[0]
	y=self.pos[1]

    @moves << [x-1,y-1] if  x-1>-1 && y-1>-1 && (@own_pieces.include? (board[x-1][y-1])) ==false
    @moves << [x-1,y] if  x-1>-1 && (@own_pieces.include? (board[x-1][y])) ==false
    @moves << [x-1,y+1] if x-1>-1 && y+1<8 && (@own_pieces.include? (board[x-1][y+1])) ==false
    @moves << [x,y-1] if y-1>-1 && (@own_pieces.include? (board[x][y-1])) ==false
    @moves << [x,y+1] if y+1<8 && (@own_pieces.include? (board[x][y+1])) ==false
    @moves << [x+1,y-1] if x+1<8 && y-1>-1 && (@own_pieces.include? (board[x+1][y-1]))==false 
    @moves << [x+1,y] if x+1<8 && (@own_pieces.include? (board[x+1][y])) ==false
    @moves << [x+1,y+1] if x+1<8 && y+1<8 && (@own_pieces.include? (board[x+1][y+1])) ==false
    check_moves=[]
    puts "moves right now #{@moves}"
    @moves.each do |y|
      @opp_moves.each do |key, value|
        if (value.include?(y)==true)
        	check_moves << y
        end
      end
    end
    @moves-=check_moves
	puts "moves: #{@moves}"
	@moves.each do |x|
		puts "King is in check" if board[x[0]][x[1]]=="K_W" || board[x[0]][x[1]]=="K_B"
	end
end



end