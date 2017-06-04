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
  #you may need to update things like blakc/white pieces and the grid each time a different
  #piece captures, otherwise the different pieces won't be updated
  @RW1=Rook.new([7,0], "RW1", @board.grid)
  @RB1=Rook.new([0,7], "RB1", @board.grid)
  @RW2=Rook.new([7,7], "RW2", @board.grid)
  @RB2=Rook.new([0,0], "RB2", @board.grid)
  @BW1=Bishop.new([7,2], "BW1", @board.grid)
  @BB1=Bishop.new([0,5], "BB1", @board.grid)
  @white_pieces=["RW1","RW2","BW1"]
  @black_pieces=["RB1","RB2","BB1"]
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
	  when "RW1"
	  	@RW1.find_moves(@black_pieces, @white_pieces) 
	  	@RW1.move	
	  	@RW1.find_moves(@black_pieces, @white_pieces) if @counter>2
	  when "RW2"
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@RW2.move	
	  	@RW2.find_moves(@black_pieces, @white_pieces) if @counter>2
	  when "BW1"
	  	@BW1.find_moves(@black_pieces, @white_pieces)
	  	@BW1.move	
	  	@BW1.find_moves(@black_pieces, @white_pieces) if @counter>2
    end
  elsif !@white_turn
  	new_move = case @choice
	  when "RB1"
	  	@RB1.find_moves(@white_pieces,@black_pieces) 
	  	@RB1.move
	  	@RB1.find_moves(@white_pieces,@black_pieces) if @counter>2
	  when "RB2"
	  	@RB2.find_moves(@white_pieces,@black_pieces) 
	  	@RB2.move
	  	@RB2.find_moves(@white_pieces,@black_pieces) if @counter>2
	  when "BB1"
	  	@BB1.find_moves(@white_pieces,@black_pieces)
	  	@BB1.move	
	  	@BB1.find_moves(@white_pieces,@black_pieces) if @counter>2
    end
  end
end

def remove_captured
	@white_pieces.each do |x|
		found=false
		@board.grid.each { |y| 
			found=true if y.include? x
		}
		@white_pieces.delete(x) if found==false
	end

	@black_pieces.each do |x|
		found=false
		@board.grid.each { |y| 
			found=true if y.include? x
		}
		@black_pieces.delete(x) if found==false
	end
	puts @white_pieces
	puts @black_pieces

end

def gameflow
  #set this to while gameover==false
  #once conditions in game change you can make gameover=true
  while @counter<4
	@counter % 2 ==0 ? @white_turn=false : @white_turn=true
	display_board
	get_user_choice
	get_new_pos
	display_board
	remove_captured
	@counter+=1
  end
end


end

game=Chess.new()
game.gameflow