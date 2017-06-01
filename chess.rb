require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
#add in serialization after

class Chess
attr_accessor :choice,:RW

def initialize
  @board=Board.new
  @RW=Rook.new([7][1] ,"RW")
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
	puts "Please choose which piece to make:"
	@choice=gets.chomp
	valid=false
	@board.grid.each do |x|
		valid=true if x.include? (choice) 
	end

	while valid==false do
	  get_user_choice
	end

end

def get_new_pos
  #based on what piece the user selects, use that pieces move method
  new_move = case @choice
	when "RW" then @RW.move
  end
  
end

def gameflow
	display_board
	get_user_choice
	get_new_pos
end


end

game=Chess.new
game.gameflow