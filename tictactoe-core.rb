END_CONDITION_WIN=0
END_CONDITION_DRAW=1

class Game
    attr_reader :field
    def initialize(player1, player2, loops=0)
        @field = Array.new(9, " ")
        @player1, @player2 = player1, player2
        @activePlayer = @player1
        @symbols = {player1 => "X", player2 => "O"}
        @loops = loops
        self.run
    end

    def run
        loop do
            self.write
            self.setMarker
            self.end(END_CONDITION_WIN) if self.checkWin
            self.end(END_CONDITION_DRAW) if self.checkDraw
            if @activePlayer.eql?(@player1)
                @activePlayer = @player2
            else
                @activePlayer = @player1
            end
        end
    end

    def setMarker
        pos = @activePlayer.getPos until (0..8).include?(pos) && @field[pos].eql?(" ")
        @field[pos] = @symbols[@activePlayer]
    end

    def end(condition)
        self.write
        case condition
        when END_CONDITION_WIN
            puts "#{@activePlayer.name} won the game."
        when END_CONDITION_DRAW
            puts "The game ended in a draw."
        else
            puts "The game ended for an unexepted reason."
        end
        self.initialize(@player1, @player2, @loops-1) if @loops>0
        puts "Do you want to restart the game? (y/n)"
        input = @activePlayer.getInput.lower until ["y", "n"].include? input
        exit if input.eql? "n"
        self.initialize(@player1, @player2) if input.eql? "y"
        throw RuntimeError "Unexcepted Value of String!"
    end
        

    def write
        for i in 0..8 
            print "[#{@field[i]}]"
            puts "" if (i%3).zero?
        end
        puts "Player #{@activePlayer.name}"
    end

    def checkWin
        symbol = @symbols[@activePlayer]
        return true if (checkRows(symbol) || checkCols(symbol) || checkDiag(symbol))
        return false
    end

    def checkRows(symbol)
        for row in 1..3
            return true if checkRow(row, symbol)
        end
        return false
    end

    def checkRow(row, symbol)
        pos = (row-1)*3
        3.times do
            return false unless @field[pos].eql? symbol
            pos += 1
        end
        return true
    end

    def checkCols(symbol)
        for col in 1..3
            return true if checkCol(col, symbol)
        end
        return false
    end

    def checkCol(col, symbol)
        pos = (col-1)
        3.times do
            return false unless @field[pos].eql? symbol
            pos += 3
        end
        return true
    end

    def checkDiag(symbol)
        return false unless @field[4].eql? symbol
        return true if ((@field[0].eql? symbol) && (@field[8].eql? symbol))
        return true if ((@field[2].eql? symbol) && (@field[6].eql? symbol))
        return false
    end

    def checkDraw
        return true unless @field.include?(" ")
        return false
    end 
end

=begin
    [0][1][2]
    [3][4][5]
    [6][7][8]
=end