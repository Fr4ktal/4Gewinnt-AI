END_CONDITION_WIN=0
END_CONDITION_DRAW=1

module TicTacToe
    class Game
        def initialize(player1, player2, loops=0)
            @field = Field.new(Array.new(9, " "))
            @activePlayer = player1
            @nonActivePlayer = player2
            player1.symbol="X"
            player2.symbol="O"
			player1.otherSymbol=player2.symbol if player1.is_ai?
			player2.otherSymbol=player1.symbol if player2.is_ai?
            @loops = loops
            self.run
        end

        def run
            loop do
                self.setMarker
                return self.end(END_CONDITION_WIN) if @field.checkWin(@activePlayer.symbol)
                return self.end(END_CONDITION_DRAW) if @field.checkDraw()
                @activePlayer, @nonActivePlayer = @nonActivePlayer, @activePlayer
            end
        end

        def setMarker
            pos = @activePlayer.getPos(@field) until (0..8).include?(pos) && @field[pos].eql?(" ")
            @field.field[pos] = @activePlayer.symbol
        end

        def end(condition)
            case condition
            when END_CONDITION_WIN
                @activePlayer.write(@field.field, "#{@activePlayer.name} won the game.")
            when END_CONDITION_DRAW
                @activePlayer.write(@field.field, "The game ended in a draw.")
            else
                @activePlayer.write(@field.field, "The game ended for an unexepted reason.")
            end
            TicTacToe::Game.new(@nonActivePlayer, @activePlayer, @loops-1) if @loops>0
            puts "Do you want to restart the game? (y/n)"
            input = @activePlayer.getInput.capitalize until ["Y", "N"].include? input
            return if input.eql? "N"
            TicTacToe::Game.new(@nonActivePlayer, @activePlayer) if input.eql? "Y"
            fail
        end
    end

    class Field
        attr_accessor :field
        def initialize(field=Array.new(9," "))
            @field = field
        end

        public
        def checkWin(field=@field, symbol)
            return true if (checkRows(field, symbol) || checkCols(field, symbol) || checkDiag(field, symbol))
            return false
        end
        
        def [](i)
        	return @field[i]
        end

        def checkRows(field=@field, symbol)
        	row=1
        	3.times do
        		puts "CheckRows: "+row.to_s+", "+symbol
            	return true if checkRow(field, row, symbol)
            	row+=1
        	end
            return false
        end

        def checkRow(field=@field, row, symbol)
            pos = (row-1)*3
            3.times do
                return false unless field[pos].eql?(symbol)
                pos += 1
            end
            return true
        end

        def checkCols(field=@field, symbol)
            for col in 1..3
                return true if checkCol(field, col, symbol)
            end
            return false
        end

        def checkCol(field=@field, col, symbol)
            pos = (col-1)
            3.times do
                return false unless field[pos].eql?(symbol)
                pos += 3
            end
            return true
        end

        def checkDiag(field=@field, symbol)
            return false unless field[4].eql?(symbol)
            return true if ((field[0].eql?(symbol)) && (field[8].eql?(symbol)))
            return true if ((field[2].eql?(symbol)) && (field[6].eql?(symbol)))
            return false
        end

        def checkDraw(field=@field)
            return true unless field.include?(" ")
            return false
        end 
        
        def inspect
            return @field.to_s
        end
    end

end

=begin
    [0][1][2]
    [3][4][5]
    [6][7][8]
=end