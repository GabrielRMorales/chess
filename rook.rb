class Rook

attr_accessor :sym, :pos, :moves

def initialize(pos, sym)
@pos=pos
@sym=sym
#set potential moves here
#normally there are no opening moves to make
@moves=[]
end

def move
	puts "check"

end

def find_move
	#reset potential moves after every move
	@moves=[]

end


end