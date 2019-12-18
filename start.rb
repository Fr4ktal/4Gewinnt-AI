require_relative "tictactoe-core.rb"
require_relative "tictactoe-player-human.rb"
require_relative "tictactoe-player-ai.rb"

def is_human?(player)
    puts("Is Player #{player} human? (y/n)")
    answer = gets().chop()
    case answer
    when "Y", "y"
        return true
    when "N", "n"
        return false
    else
        return is_human?(player)
    end
end

def createPlayer(i, symbol)
	if is_human?(i)
        print("Name: ")
        p=PlayerHuman.new(gets().chop())
    else
        p=PlayerAI.new("AI-#{i}")
    end
    p.symbol=symbol
    return p
end

def start
    p1= createPlayer(1, "X")
    p2 = createPlayer(2,"O")
	p1.otherSymbol=p2.symbol if p1.is_ai?()
	p2.otherSymbol=p1.symbol if p2.is_ai?()
    TicTacToe::Game.new(p1,p2)
end
start()