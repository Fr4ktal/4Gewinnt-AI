require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    attr_accessor :otherSymbol

    def initialize(name)
        super(name)
    	@otherSymbol=""
        @firstturn=true
    end
    
    def is_ai?
    	return true
    end

    def getInput
        return super
    end

    def write(field, msg="Player #{@name}")
        super(field, msg)
    end

    def evalPos(field)
    	if @firstturn
    		@firstturn=false
    		return rand(9) if @firstturn
	    end
        return minimax(field, @symbol, @otherSymbol, true)
    end

    def getPos(field)
        pos= evalPos(field)
        puts pos.to_s+"; "+@otherSymbol
        return pos
    end

    def minimax(field, symbol, otherSymbol, isMaximizing, depth=0)
        freeSpaces = []
        bestScore = -Float::INFINITY
        bestPos=rand(9)
        score = 0
        return 1 if field.checkWin(symbol)
        return -1 if field.checkWin(otherSymbol)
        return 0 if field.checkDraw
		field.field.map.with_index { |element, i| freeSpaces.push(i) if element.eql? " "}
        freeSpaces.each { |i|
        	tempField=field
        	tempField.field[i]=symbol
            score = minimax(tempField, otherSymbol, symbol, !isMaximizing, depth+1)
            if isMaximizing
				bestScore = score if score > bestScore
				bestPos=i
			else
				bestScore=score if score<bestScore
			end
			return bestPos if depth.eql? 0
        }
        return bestScore
    end
end