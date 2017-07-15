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
:black_moves, :gameover

def initialize()
  @gameover=false
  @board=Board.new
  #set @white_moves and @black_moves at the beginning-they will update for x piece when x piece moves
  @white_moves={"PW1"=>[], "RW1"=>[], "RW2"=>[], "K_W"=>[], "BW1"=>[] }
  @black_moves={"PB1"=>[], "RB1"=>[], "RW2"=>[], "K_B"=>[], "BB1"=>[] }

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

  @white_pieces=["PW1","RW1","RW2","K_W","BW1"]
  @black_pieces=["PB1","RB1","RB2","K_B","BB1"]

 
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
	  	@white_moves[@PW1.sym]=@PW1.get_moves	
	  when "RW1"
	  	@RW1.find_moves(@black_pieces, @white_pieces)
	  	@RW1.move	
	  	@RW1.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@RW1.sym]=@RW1.get_moves
	  	#print "White moves #{@white_moves}"
	  when "RW2"
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@RW2.move	
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@RW2.sym]=@RW2.get_moves
	  	#print "White moves #{@white_moves}"
	  when "K_W"
	  	@K_W.find_moves(@white_pieces, @black_moves)
	  	@K_W.move	
	  	@K_W.find_moves(@white_pieces, @black_moves)
	  	@white_moves[@K_W.sym]=@K_W.get_moves	
	  when "BW1"
	  	@BW1.find_moves(@black_pieces, @white_pieces) 
	  	@BW1.move	
	  	@BW1.find_moves(@black_pieces, @white_pieces) 
	  	@white_moves[@BW1.sym]=@BW1.get_moves	
    end
  elsif !@white_turn
  	new_move = case @choice
  	  when "PB1"
	  	@PB1.move(@white_pieces)
	  	@black_moves[@PB1.sym]=@PB1.get_moves
	  when "RB1"
	  	@RB1.find_moves(@white_pieces,@black_pieces) 
	  	@RB1.move
	  	@RB1.find_moves(@white_pieces,@black_pieces)
	  	@black_moves[@RB1.sym]=@RB1.get_moves
	  when "RB2"
	  	@RB2.find_moves(@white_pieces,@black_pieces)
	  	@RB2.move
	  	@RB2.find_moves(@white_pieces,@black_pieces)
	  	@black_moves[@RB2.sym]=@RB2.get_moves
	  when "K_B"
	  	@K_B.find_moves(@black_pieces,@white_moves)
	  	@K_B.move	
	  	@K_B.find_moves(@black_pieces,@white_moves)
	  	@black_moves[@K_B.sym]=@K_B.get_moves
	  when "BB1"
	  	@BB1.find_moves(@white_pieces,@black_pieces)
	  	@BB1.move
	  	@BB1.find_moves(@white_pieces,@black_pieces)
	  	@black_moves[@BB1.sym]=@BB1.get_moves
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
		if x=="K_W" && found==false
			@gameover=true 
			puts "Black wins!"
		end
	end

	@black_pieces.each do |x|
		found=false
		@board.grid.each { |y| 
			found=true if y.include? x
		}
		@black_pieces.delete(x) if found==false
		if x=="K_B" && found==false
			@gameover=true 
			puts "White wins!"
		end
	end
	#puts @white_pieces
	#puts @black_pieces

end

def gameflow
	display_board
  while @gameover==false
	@counter % 2 ==0 ? @white_turn=false : @white_turn=true
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