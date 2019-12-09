require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    attr_accessor :otherSymbol

    def initialize(name)
        super(name)
    	@otherSymbol=""
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

    def minimax(field, symbol, otherSymbol, isMaximizing)
        freeSpaces = []
        bestScore = -Float::INFINITY
        score = 0

        return 1 if field.checkWin(symbol)
        return -1 if field.checkWin(otherSymbol)
        return 0 if field.checkDraw
		field.field.map.with_index { |element, i| freeSpaces.push(i) if element.eql? " "}
        freeSpaces.each { |i|
        	dummyField=field
        	dummyField.field[i]=symbol
            nextIsMaximizing = !isMaximizing
            score = minimax(dummyField, otherSymbol, symbol, nextIsMaximizing)
            if isMaximizing
				bestScore = score if score > bestScore
			else
				bestScore=score if score<bestScore
			end
        }
        return bestScore
    end
end