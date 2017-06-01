require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
#add in serialization after

class Chess
attr_accessor :choice, :board, :counter, :white_turn, :white_pieces, :black_pieces

def initialize()
  @board=Board.new
  @RW=Rook.new([7,1],"RW", @board.grid)
  @RB=Rook.new([0,6],"RB", @board.grid)
  @white_pieces=["RW"]
  @black_pieces=["RB"]
  @counter=1
  @white_turn=true

end

def display_board
	puts ""
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
	if @white_turn==true
	  valid=true if @white_pieces.include? (@choice)

	elsif @white_turn==false	
	  valid=true if @black_pieces.include? (@choice)
	end

  end

end

def get_new_pos	
  #based on what piece the user selects, use that pieces move method
  if @white_turn
    new_move = case @choice
	  when "RW" then @RW.move	
    end
  elsif !@white_turn
  	new_move = case @choice
	  when "RB" then @RB.move	
    end
  end
end

def gameflow
  #set this to while gameover==false
  #once conditions in game change you can make gameover=true
  while @counter<3
	@counter % 2 ==0 ? @white_turn=false : @white_turn=true
	display_board
	get_user_choice
	get_new_pos
	display_board
	@counter+=1
  end
end


end

game=Chess.new()
game.gameflow