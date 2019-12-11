require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    attr_accessor :otherSymbol

    def initialize(name)
        super(name)
    	@otherSymbol=""
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
        return minimax(field, @symbol, @otherSymbol)
    end

    def getPos(field)
        pos= evalPos(field)
        return pos
    end

    def minimax(field, symbol, otherSymbol, depth=0)
        freeSpaces = []
        pos={
            -1=>[],
            0=>[],
            1=> []
            }
        score = 0
        bestScore = -1
        return 1 if field.checkWin(symbol)
        return -1 if field.checkWin(otherSymbol)
        return 0 if field.checkDraw
        field.field.each.with_index { |element, i|
			freeSpaces.push(i) if element.eql? " "
        }
        freeSpaces.each { |i|
        	tempField=TicTacToe::Field.new(field.field)
            tempField.field[i]=symbol
            score = minimax(tempField, otherSymbol, symbol, depth+1)
            if depth.eql? 0
                case score
                when 1
                    pos[1].push(i)
                when 0
                    pos[0].push(i)
                when -1
                    pos[-1].push(i)
                end
            else
                bestScore = score if score > bestScore
            end
        }
        if depth.eql? 0
            return pos[1].sample unless pos[1].empty?
            return pos[0].sample unless pos[0].empty?
            return pos[-1].sample unless pos[-1].empty?
        else
            return bestScore
        end
    end
end