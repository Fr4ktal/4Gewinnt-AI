END_CONDITION_WIN=0
END_CONDITION_DRAW=1

module TicTacToe
    class Game
        def initialize(player1, player2, loops=0)
            @field = Array.new(9, " ")
            @activePlayer = player1
            @nonActivePlayer = player2
            player1.symbol="X", player2.symbol="O"
            player1.otherSymbol = player2.symbol if player1.IS_AI
            player2.otherSymbol = player1.symbol if player2.IS_AI
            @loops = loops
            self.run
        end

        def run
            loop do
                self.setMarker
                return self.end(END_CONDITION_WIN) if self.checkWin(@activePlayer.symbol)
                return self.end(END_CONDITION_DRAW) if self.checkDraw(field)
                @activePlayer, @nonActivePlayer = @nonActivePlayer, @activePlayer
            end
        end

        def setMarker
            pos = @activePlayer.getPos(@field) until (0..8).include?(pos) && @field[pos].eql?(" ")
            @field[pos] = @activePlayer.symbol
        end

        def end(condition)
            case condition
            when END_CONDITION_WIN
                @activePlayer.write(@field, "#{@activePlayer.name} won the game.")
            when END_CONDITION_DRAW
                @activePlayer.write(@field, "The game ended in a draw.")
            else
                @activePlayer.write(@field, "The game ended for an unexepted reason.")
            end
            TicTacToe::Game.new(@nonActivePlayer, @activePlayer, @loops-1) if @loops>0
            puts "Do you want to restart the game? (y/n)"
            input = @activePlayer.getInput.capitalize until ["Y", "N"].include? input
            return if input.eql? "N"
            TicTacToe::Game.new(@nonActivePlayer, @activePlayer) if input.eql? "Y"
            fail
        end
    end

    public
    def checkWin(field, symbol)
        return true if (checkRows(field, symbol) || checkCols(field, symbol) || checkDiag(field, symbol))
        return false
    end

    def checkRows(field, symbol)
        for row in 1..3
            return true if checkRow(field, row, symbol)
        end
        return false
    end

    def checkRow(field, row, symbol)
        pos = (row-1)*3
        3.times {
            return false unless field[pos].eql?(symbol)
            pos += 1
        }
        return true
    end

    def checkCols(field, symbol)
        for col in 1..3
            return true if checkCol(field, col, symbol)
        end
        return false
    end

    def checkCol(field, col, symbol)
        pos = (col-1)
        3.times do
            return false unless field[pos].eql?(symbol)
            pos += 3
        end
        return true
    end

    def checkDiag(field, symbol)
        return false unless field[4].eql?(symbol)
        return true if ((field[0].eql?(symbol)) && (field[8].eql?(symbol)))
        return true if ((field[2].eql?(symbol)) && (field[6].eql?(symbol)))
        return false
    end

    def checkDraw(field)
        return true unless field.include?(" ")
        return false
    end 

end

=begin
    [0][1][2]
    [3][4][5]
    [6][7][8]
=end