require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
#add in serialization after

class Chess
attr_accessor :choice, :board

def initialize()
  @board=Board.new
  @RW=Rook.new([7,1],"RW")
end

def display_board
  @board.grid.each { |x| 
	x.each { |y|
	print y
	}
	puts ""
	}
end

def get_user_choice
	valid=false

	while valid==false do
	puts "Please choose which piece to move:"
	@choice=gets.chomp
	
		@board.grid.each do |x|
			valid=true if x.include? (@choice) 
		end
	end

end

def get_new_pos
	
  #based on what piece the user selects, use that pieces move method
  new_move = case @choice
	when "RW" then @RW.move(@board.grid, @RW.pos)
  end

end

def gameflow
	display_board
	#puts "RW test is #{@RW.sym}"
	#puts "RW pos is #{@RW.pos}"
	get_user_choice
	get_new_pos
	display_board
	puts @RW.pos
end


end

game=Chess.new()
game.gameflow