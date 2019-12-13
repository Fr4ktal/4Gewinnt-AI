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

    def getPos(field)
        return 4 if field.field[4].eql?" "
        return minimax(field, @symbol, @otherSymbol)
    end

    def minimax(field, symbol, otherSymbol, depth=0)
        return 1 if field.checkWin(symbol)
        return -1 if field.checkWin(otherSymbol)
        return 0 if field.checkDraw
        
        freeSpaces = []
        pos={
            :winNext=>[],
            :preventLoose=> [],
            :restMayWin=> [],
            :restMayLoose=>[],
            :rest=>[]
            }
        score = 0
        bestScore = -1
        
        field.field.each.with_index { |element, i|
			freeSpaces.push(i) if element.eql? " "
        }
        freeSpaces.each { |i|
        	tempField=TicTacToe::Field.new(field.field)
            tempField.field[i]=symbol
            score = minimax(tempField, otherSymbol, symbol, depth+1)
            if depth.eql? 0
            	pos[:winNext].push(i) if tempField.checkWin(symbol)
            	tempField.field[i]=otherSymbol
            	pos[:preventLoose].push(i) if tempField.checkWin(otherSymbol)
                case score
                when 1
                    pos[:restMayWin].push(i)
                when 0
                    pos[:rest].push(i)
                when -1
                    pos[:restMayLoose].push(i)
                end
            else
                bestScore = score if score > bestScore
            end
        }
        if depth.eql? 0
        	return pos[:winNext].sample unless pos[:winNext].empty?
        	return pos[:preventLoose].sample unless pos[:preventLoose].empty?
            return pos[:restMayWin].sample unless pos[:restMayWin].empty?
            return pos[:rest].sample unless pos[:rest].empty?
            return pos[:restMayLoose].sample unless pos[:restMayLoose].empty?
        else
            return bestScore
        end
    end
    	
end