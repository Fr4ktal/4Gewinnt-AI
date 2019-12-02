require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    attr_reader :IS_AI
    attr_accessor :otherSymbol

    def initialize(name)
        @IS_AI=true
        @otherSymbol=nil
        super(name)
    end

    def getInput
        return super
    end

    def write(field, msg="Player #{@name}")
        super(field, msg)
    end

    def evalPos(field)
        return minimax(field, @symbol, @otherSymbol, true)
        return rand(0..8)
    end

    def getPos(field)
        return evalPos(field)
    end

    def minimax(field, symbol, otherSymbol, isMaximizing)
        freeSpaces = []
        bestScore = -Float::INFINITY
        score = 0

        return 1 if TicTacToe::Field.new(field).checkWin(field, symbol)
        return -1 if TicTacToe::Field.checkWin(field, otherSymbol)
        freeSpaces = field.map.with_index { |element, i| i if element.eql? " "}
        return 0 if freeSpaces.empty?
        freeSpaces.each {
            isMaximizing = !isMaximizing
            score = minimax(field, @otherSymbol, @symbol, isMaximizing)
            bestScore = score if score > bestScore
        }
        return bestScore
    end
end