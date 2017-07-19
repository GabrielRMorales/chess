require_relative "board.rb"
require_relative "king.rb"
require_relative "queen.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
require "yaml"

class Chess
attr_accessor :choice, :board, :counter, :white_turn,
			  :white_pieces, :black_pieces, :white_moves,
  			  :black_moves, :gameover, :king_is_in_check,
			  :PW1, :PW2,:PW3,:PW4,:PW5,:PW6,:PW7,:PW8,
			  :PB1, :PB2,:PB3,:PB4,:PB5,:PB6,:PB7,:PB8

def initialize()
  @gameover=false
  @king_is_in_check=false
  @board=Board.new
  #set @white_moves and @black_moves at the beginning-they will update for x piece when x piece moves
  @white_moves={"PW1"=>[],"PW2"=>[],"PW3"=>[],"PW4"=>[],"PW5"=>[],"PW6"=>[],
  "PW7"=>[],"PW8"=>[], "RW1"=>[], "RW2"=>[], "KW1"=>[], "KW2"=>[],
  "Q_W"=>[],"K_W"=>[], "BW1"=>[],"BW2"=>[] }
  @black_moves={"PB1"=>[],"PB2"=>[],"PB3"=>[],"PB4"=>[],"PB5"=>[],"PB6"=>[],
  	"PB7"=>[],"PB8"=>[], "RB1"=>[], "RB2"=>[], "KB1"=>[], "KB2"=>[],
  	 "Q_B"=>[],"K_B"=>[], "BB1"=>[],"BB2"=>[] }

  @PW1=Pawn.new([6,0], "PW1", @board.grid, true)
  @PW2=Pawn.new([6,1], "PW2", @board.grid, true)
  @PW3=Pawn.new([6,2], "PW3", @board.grid, true)
  @PW4=Pawn.new([6,3], "PW4", @board.grid, true)
  @PW5=Pawn.new([6,4], "PW5", @board.grid, true)
  @PW6=Pawn.new([6,5], "PW6", @board.grid, true)
  @PW7=Pawn.new([6,6], "PW7", @board.grid, true)
  @PW8=Pawn.new([6,7], "PW8", @board.grid, true)

  @PB1=Pawn.new([1,0], "PB1", @board.grid, false)
  @PB2=Pawn.new([1,1], "PB2", @board.grid, false)
  @PB3=Pawn.new([1,2], "PB3", @board.grid, false)
  @PB4=Pawn.new([1,3], "PB4", @board.grid, false)
  @PB5=Pawn.new([1,4], "PB5", @board.grid, false)
  @PB6=Pawn.new([1,5], "PB6", @board.grid, false)
  @PB7=Pawn.new([1,6], "PB7", @board.grid, false)
  @PB8=Pawn.new([1,7], "PB8", @board.grid, false)

  @K_W=King.new([7,4], "K_W", @board.grid)
  @K_B=King.new([0,4], "K_B", @board.grid)

  @Q_W=Queen.new([7,3], "Q_W", @board.grid)
  @Q_B=Queen.new([0,3], "Q_B", @board.grid)

  @RW1=Rook.new([7,0], "RW1", @board.grid)
  @RB1=Rook.new([0,7], "RB1", @board.grid)

  @RW2=Rook.new([7,7], "RW2", @board.grid)
  @RB2=Rook.new([0,0], "RB2", @board.grid)

  @KW1=Knight.new([7,1], "KW1", @board.grid)
  @KW2=Knight.new([7,6], "KW2", @board.grid)

  @KB1=Knight.new([0,1], "KB1", @board.grid)
  @KB2=Knight.new([0,6], "KB2", @board.grid)

  @BW1=Bishop.new([7,2], "BW1", @board.grid)
  @BW2=Bishop.new([7,5], "BW2", @board.grid)

  @BB1=Bishop.new([0,5], "BB1", @board.grid)
  @BB2=Bishop.new([0,2], "BB2", @board.grid)

  @white_pieces=["PW1","PW2","PW3","PW4","PW5","PW6",
  	"PW7","PW8","RW1","RW2","Q_W","K_W","KW1","KW2","BW1","BW2"]
  @black_pieces=["PB1","PB2","PB3","PB4","PB5","PB6",
  	"PB7","PB8","RB1","RB2","Q_B","K_B","KB1", "KB2", "BB1","BB2"]
 
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
  if @white_turn
    new_move = case @choice
      when "PW1"
	  	@PW1.move(@black_pieces)
	  	@white_moves[@PW1.sym]=@PW1.get_moves
	  	promote_pawn(@PW1, 0)
	  when "PW2"
	  	@PW2.move(@black_pieces)
	  	@white_moves[@PW2.sym]=@PW2.get_moves
	  	promote_pawn(@PW2, 0)
	  when "PW3"
	  	@PW3.move(@black_pieces)
	  	@white_moves[@PW3.sym]=@PW3.get_moves
	  	promote_pawn(@PW3, 0)
	  when "PW4"
	  	@PW4.move(@black_pieces)
	  	@white_moves[@PW4.sym]=@PW4.get_moves
	  	promote_pawn(@PW4, 0)
	  when "PW5"
	  	@PW5.move(@black_pieces)
	  	@white_moves[@PW5.sym]=@PW5.get_moves
	  	promote_pawn(@PW5, 0)
	  when "PW6"
	  	@PW6.move(@black_pieces)
	  	@white_moves[@PW6.sym]=@PW6.get_moves
	  	promote_pawn(@PW6, 0)
	  when "PW7"
	  	@PW7.move(@black_pieces)
	  	@white_moves[@PW7.sym]=@PW7.get_moves
	  	promote_pawn(@PW7, 0)
	  when "PW8"
	  	@PW8.move(@black_pieces)
	  	@white_moves[@PW8.sym]=@PW8.get_moves
	  	promote_pawn(@PW8, 0)
	  when "Q_W"
	  	@Q_W.find_moves(@black_pieces, @white_pieces)
	  	@Q_W.move
	  	@Q_W.find_moves(@black_pieces, @white_pieces)
	  	@white_moves[@Q_W.sym]=@Q_W.get_moves
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
	  when "KW1"
	  	@KW1.find_moves(@white_pieces)
	  	@KW1.move	
	  	@KW1.find_moves(@white_pieces)
	  	@white_moves[@KW1.sym]=@KW1.get_moves
	  when "KW2"
	  	@KW2.find_moves(@white_pieces)
	  	@KW2.move	
	  	@KW2.find_moves(@white_pieces)
	  	@white_moves[@KW2.sym]=@KW2.get_moves
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
	  when "BW2"
	  	@BW2.find_moves(@black_pieces, @white_pieces) 
	  	@BW2.move	
	  	@BW2.find_moves(@black_pieces, @white_pieces) 
	  	@white_moves[@BW2.sym]=@BW2.get_moves	
    end
  elsif !@white_turn
  	new_move = case @choice
  	  when "PB1"
	  	@PB1.move(@white_pieces)
	  	@black_moves[@PB1.sym]=@PB1.get_moves
	  	promote_pawn(@PB1, 6)
	  when "PB2"
	  	@PB2.move(@white_pieces)
	  	@black_moves[@PB2.sym]=@PB2.get_moves
	  	promote_pawn(@PB2, 6)
	  when "PB3"
	  	@PB3.move(@white_pieces)
	  	@black_moves[@PB3.sym]=@PB3.get_moves
	  	promote_pawn(@PB3, 6)
	  when "PB4"
	  	@PB4.move(@white_pieces)
	  	@black_moves[@PB4.sym]=@PB4.get_moves
	  	promote_pawn(@PB4, 6)
	  when "PB5"
	  	@PB5.move(@white_pieces)
	  	@black_moves[@PB5.sym]=@PB5.get_moves
	  	promote_pawn(@PB5, 6)
	  when "PB6"
	  	@PB6.move(@white_pieces)
	  	@black_moves[@PB6.sym]=@PB6.get_moves
	  	promote_pawn(@PB6, 6)
	  when "PB7"
	  	@PB7.move(@white_pieces)
	  	@black_moves[@PB7.sym]=@PB7.get_moves
	  	promote_pawn(@PB7, 6)
	  when "PB8"
	  	@PB8.move(@white_pieces)
	  	@black_moves[@PB8.sym]=@PB8.get_moves
	  	promote_pawn(@PB8, 6)
	  when "Q_B"
	  	@Q_B.find_moves(@white_pieces, @black_pieces)
	  	@Q_B.move
	  	@Q_B.find_moves(@white_pieces, @black_pieces)
	  	@black_moves[@Q_B.sym]=@Q_B.get_moves
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
	  when "KB1"
	  	@KB1.find_moves(@black_pieces) 
	  	@KB1.move
	  	@KB1.find_moves(@black_pieces)
	  	@black_moves[@KB1.sym]=@KB1.get_moves
	  when "KB2"
	  	@KB2.find_moves(@black_pieces)
	  	@KB2.move
	  	@KB2.find_moves(@black_pieces)
	  	@black_moves[@KB2.sym]=@KB2.get_moves
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
	  when "BB2"
	  	@BB2.find_moves(@white_pieces,@black_pieces)
	  	@BB2.move
	  	@BB2.find_moves(@white_pieces,@black_pieces)
	  	@black_moves[@BB2.sym]=@BB2.get_moves
    end
  end
end

def promote_pawn(x,y)
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
    @PW2=loaded_game[:PW2]
    @PW3=loaded_game[:PW3]
    @PW4=loaded_game[:PW4]
    @PW5=loaded_game[:PW5]
    @PW6=loaded_game[:PW6]
    @PW7=loaded_game[:PW7]
    @PW8=loaded_game[:PW8]

    @RW1=loaded_game[:RW1]
    @RW2=loaded_game[:RW2]
    @KW1=loaded_game[:KW1]
    @KW2=loaded_game[:KW2]
    @Q_W=loaded_game[:Q_W]
    @K_W=loaded_game[:K_W]
    @BW1=loaded_game[:BW1]
    @BW2=loaded_game[:BW2]

    @PB1=loaded_game[:PB1]
    @PB2=loaded_game[:PB2]
    @PB3=loaded_game[:PB3]
    @PB4=loaded_game[:PB4]
    @PB5=loaded_game[:PB5]
    @PB6=loaded_game[:PB6]
    @PB7=loaded_game[:PB7]
    @PB8=loaded_game[:PB8]

    @RB1=loaded_game[:RB1]
    @RB2=loaded_game[:RB2]
    @KB1=loaded_game[:KB1]
    @KB2=loaded_game[:KB2]
    @Q_B=loaded_game[:Q_B]
    @K_B=loaded_game[:K_B]
    @BB1=loaded_game[:BB1]
    @BB2=loaded_game[:BB2]

end

def save
  saved_game={
  		:choice=>@choice,:board=>@board, :counter=>@counter, :white_turn=>@white_turn,
  		:white_pieces=>@white_pieces, :black_pieces=>@black_pieces, :white_moves=>@white_moves,
  		:black_moves=>@black_moves, :gameover=>@gameover, :king_is_in_check=>@king_is_in_check, 
  		:PW1=>@PW1,:PW2=>@PW2,:PW3=>@PW3,:PW4=>@PW4,:PW5=>@PW5,:PW6=>@PW6,
  		:PW7=>@PW7,:PW8=>@PW8, :RW1=>@RW1, :RW2=>@RW2, :KW1=>@KW1, :KW2=>@KW2,
  		:K_W=>@K_W, :BW1=>@BW1, :Q_W=>@Q_W, :BW2=>@BW2,


  		:PB1=>@PB1,:PB2=>@PB2,:PB3=>@PB3,:PB4=>@PB4,:PB5=>@PB5,:PB6=>@PB6,
  		:PB7=>@PB7,:PB8=>@PB8, :RB1=>@RB1, :RB2=>@RB2, :KB1=>@KB1, :KB2=>@KB2,
  		:K_B=>@K_B, :BB1=>@BB1, :Q_B=>@Q_B, :BB2=>@BB2, 		
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