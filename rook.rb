#require_relative "board.rb"

class Rook

attr_accessor :pos, :sym, :moves

def initialize(pos, sym)
@pos=pos
@sym=sym

#set potential moves here
#normally there are no opening moves to make
@moves=[]
end

def move(grid, self_pos)
	#puts grid[7][0]
	puts "Where would you like to move this rook? Enter the coords as a 2-digit number"
	new_pos=gets.chomp
	x=new_pos[0].to_i
	y=new_pos[1].to_i
	#puts grid[x][y]
	#if @moves.include? (new_pos)
	  grid[x][y]=self.sym
	  grid[self_pos[0]][self_pos[1]]="__"
	  self.pos=new_pos
	#else
	 
	  #move
	#end

end

def find_move
	#reset potential moves after every move
	@moves=[]

end


end