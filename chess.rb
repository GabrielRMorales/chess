require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
require "yaml"

class Chess
attr_accessor :choice, :board, :counter, :white_turn, :white_pieces, :black_pieces, :white_moves,
:black_moves, :gameover, :king_is_in_check

def initialize()
  @gameover=false
  @king_is_in_check=false
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
	  	promote_pawn(@PW1, 0)	
	  when "RW1"
	  	@RW1.find_moves(@black_pieces, @white_pieces)
	  	@RW1.move	
	  	@RW1.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@RW1.sym]=@RW1.get_moves
	  when "RW2"
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@RW2.move	
	  	@RW2.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@RW2.sym]=@RW2.get_moves
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
	  	promote_pawn(@PB1, 6)
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

def promote_pawn(x,y)
	#for white, y should be 0, for black, y should be 6
    if x.get_pos[0]==y
	  		puts "Would you like to promote this pawn? Y/N"
	  		promote=gets.chomp
	  	if promote=="Y" || promote=="y"
	  		puts "What piece would you like to promote it to?"
	  		p=gets.chomp
        	case p
          	when "rook"
          	  x=Rook.new([x.get_pos[0],x.get_pos[1]], x.to_s, @board.grid)
          	when "queen"
          	  x=Queen.new([x.get_pos[0],x.get_pos[1]], x.to_s, @board.grid)
          	when "knight"
          	  x=Knight.new([x.get_pos[0],x.get_pos[1]], x.to_s, @board.grid)
          	when "bishop"
          	  x=Bishop.new([x.get_pos[0],x.get_pos[1]], x.to_s, @board.grid)
      	  	end
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

end

def king_in_check
	@white_moves.each do |x,y|
		y.each do |z|
			puts "Black King is in check" if @board.grid[z[0]][z[1]]=="K_B"
			 @king_is_in_check=true
		end
	end

	@black_moves.each do |x,y|
		y.each do |z|
			puts "White King is in check" if @board.grid[z[0]][z[1]]=="K_W"
			 @king_is_in_check=true
		end
	end
	puts "white moves: #{@white_moves}"
	puts "black moves: #{@black_moves}"
end

def is_draw
	b_moves_available=true
	w_moves_available=true
	  @white_moves.each do |x,y|
        w_moves_available=false if y.empty? == false
      end
       @black_moves.each do |x,y|
        b_moves_available=false if y.empty? == false
      end

	if @king_is_in_check==false && (b_moves_available==false || w_moves_available==false)
		@gameover=true
		puts "Game is a Draw"
	elsif @white_pieces==["K_W"] && @black_pieces==["K_B"]		
		@gameover=true
		puts "Game is a Draw"
	end
end

def ask_to_load
	puts "Do you want to load. Y/N"
	response=gets.chomp
	if response=="Y" || response=="y"
		load_game
	end		
end

def ask_to_save
	puts "Do you want to save. Y/N"
	response=gets.chomp
	if response=="Y" || response=="y"
		save
	end	
end

def load_game
    loaded_game=YAML.load_file("save-file.yml")

    @choice=loaded_game[:choice]
    @board=loaded_game[:board]
    @counter=loaded_game[:counter]
    @white_turn=loaded_game[:white_turn]
    @white_pieces=loaded_game[:white_pieces]
    @black_pieces=loaded_game[:black_pieces]
    @white_moves=loaded_game[:white_moves]
    @black_moves=loaded_game[:black_moves]
    @gameover=loaded_game[:gameover]
    @king_is_in_check=loaded_game[:king_is_in_check]

    @PW1=loaded_game[:PW1]
    @RW1=loaded_game[:RW1]
    @RW2=loaded_game[:RW2]
    @K_W=loaded_game[:K_W]
    @BW1=loaded_game[:BW1]
    @PB1=loaded_game[:PB1]
    @RB1=loaded_game[:RB1]
    @RB2=loaded_game[:RB2]
    @K_B=loaded_game[:K_B]
    @BB1=loaded_game[:BB1]

end

def save
  saved_game={
  		:choice=>@choice,:board=>@board, :counter=>@counter, :white_turn=>@white_turn,
  		:white_pieces=>@white_pieces, :black_pieces=>@black_pieces, :white_moves=>@white_moves,
  		:black_moves=>@black_moves, :gameover=>@gameover, :king_is_in_check=>@king_is_in_check, 
  		:PW1=>@PW1, :RW1=>@RW1, :RW2=>@RW2, :K_W=>@K_W, :BW1=>@BW1, :PB1=>@PB1, :RB1=>@RB1,
  		:RB2=>@RB2, :K_B=>@K_B, :BB1=>@BB1, :BB2=>@BB2  		
    }
    File.open("save-file.yml","w") do |f|
      f.write(saved_game.to_yaml)
    end
end

def gameflow
	ask_to_load
	display_board
  while @gameover==false
	@counter % 2 ==0 ? @white_turn=false : @white_turn=true
	get_user_choice
	get_new_pos
	display_board
	king_in_check
	is_draw
	remove_captured	
	@counter+=1
	ask_to_save
  end
end

end

game=Chess.new()
game.gameflow