require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
#add in serialization after
#pieces must alert if the king is in check
#king must determine if it will be in check (based on potential moves of other pieces) and not allow these moves
#set up game flow such that it keeps going until a certain point
class Chess
attr_accessor :choice, :board, :counter, :white_turn, :white_pieces, :black_pieces, :white_moves,
:black_moves


def initialize()
  @board=Board.new

  @white_moves={"RW1"=> [], "RW2"=>[], "K_W"=>[] }
  @black_moves={ "RB1"=> [], "RW2"=>[], "K_B"=>[] } 
  #you may need to update things like blakc/white pieces and the grid each time a different
  #piece captures, otherwise the different pieces won't be updated
  @RW1=Rook.new([7,0], "RW1", @board.grid)
  @RB1=Rook.new([0,7], "RB1", @board.grid)
  @PW1=Pawn.new([6,0], "PW1", @board.grid, true)
  @PB1=Pawn.new([1,0], "PB1", @board.grid, true)

  @K_W=King.new([7,4], "K_W", @board.grid)
  @K_B=King.new([0,4], "K_B", @board.grid)

  @RW2=Rook.new([7,7], "RW2", @board.grid)
  @RB2=Rook.new([0,0], "RB2", @board.grid)

  @BW1=Bishop.new([7,2], "BW1", @board.grid)
  @BB1=Bishop.new([0,5], "BB1", @board.grid)

  @white_pieces=["PW1", "RW1","RW2","K_W","BW1"]
  @black_pieces=["PB1", "RB1","RB2","K_B","BB1"]

 
  @counter=1
  @white_turn=true
  #black_pieces and white_pieces should be hashes with each piece name as a symbol-each will
  #be updated only when that piece is moved

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
      when "PW1"
	  	@PW1.move(@black_pieces)
	  when "RW1"
	  	@RW1.find_moves(@black_pieces, @white_pieces)
	  	@RW1.move	
	  	@RW1.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@RW1.sym]=@RW1.get_moves
	  	print "White moves #{@white_moves}"
	  when "RW2"
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@RW2.move	
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@RW2.sym]=@RW2.get_moves
	  	print "White moves #{@white_moves}"
	  when "K_W"
	  	@K_W.find_moves(@white_pieces, @black_moves) if @counter<3
	  	@K_W.move	
	  	@K_W.find_moves(@white_pieces, @black_moves)
	  	@white_moves[@K_W.sym]=@K_W.get_moves	
	  when "BW1"
	  	@BW1.find_moves(@black_pieces, @white_pieces) if @counter<3
	  	@BW1.move	
	  	@BW1.find_moves(@black_pieces, @white_pieces) 
    end
  elsif !@white_turn
  	new_move = case @choice
  	  when "PB1"
	  	@PB1.move(@white_pieces)
	  when "RB1"
	  	@RB1.find_moves(@white_pieces,@black_pieces) 
	  	@RB1.move
	  	@RB1.find_moves(@white_pieces,@black_pieces)
	  when "RB2"
	  	@RB2.find_moves(@white_pieces,@black_pieces)
	  	@RB2.move
	  	@RB2.find_moves(@white_pieces,@black_pieces)
	  when "K_B"
	  	@K_B.find_moves(@black_pieces,@white_moves) if @counter<3
	  	@K_B.move	
	  	@K_B.find_moves(@black_pieces,@white_moves)
	  when "BB1"
	  	@BB1.find_moves(@white_pieces,@black_pieces) if @counter<3
	  	@BB1.move	
	  	@BB1.find_moves(@white_pieces,@black_pieces)
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
	#test this .get_moves to get the moves that would be added to the check_moves_to_avoid hash
	#@RW1.get_moves
	@counter+=1
  end
end


end

game=Chess.new()
game.gameflow