require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    attr_accessor :otherSymbol

    def initialize(name)
        @otherSymbol=nil
        super(name)
        @is_ai=true
        @firstturn=true
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
    		return rand(0..8) if @firstturn
    end
        return minimax(field, @symbol, @otherSymbol, true)
    end

    def getPos(field)
        return evalPos(field)
    end

    def minimax(field, symbol, otherSymbol, isMaximizing, stackLevel)
        freeSpaces = []
        bestScore = -Float::INFINITY
        score = 0

        return 1 if field.checkWin(symbol)
        return -1 if field.checkWin(otherSymbol)
        freeSpaces = field.field.map.with_index { |element, i| i if element.eql? " "}
        return 0 if freeSpaces.empty?
        freeSpaces.each { |i|
        	dummyField=field
        	dummyField[i]=symbol
            nextIsMaximizing = !isMaximizing
            score = minimax(dummyField, @otherSymbol, @symbol, nextIsMaximizing, stackLevel+1)
            if isMaximizing
				bestScore = score if score > bestScore
			else
				bestScore=score if score<bestScore
			end
        }
        return bestScore
    end
end