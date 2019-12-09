require_relative "tictactoe-core.rb"
require_relative "tictactoe-player-human.rb"
require_relative "tictactoe-player-ai.rb"

def is_human?(player)
    puts "Is Player #{player} human? (y/n)"
    answer = gets.chop
    case answer
    when "Y", "y"
        return true
    when "N", "n"
        return false
    else
        return is_human?(player)
    end
end

def start
    if is_human?(1)
        print "Name: "
        p1=PlayerHuman.new(gets.chop)
    else
        p1=PlayerAI.new("AI-1")
    end
    p1.symbol="X"
    if is_human?(2)
        print "Name: "
        p2=PlayerHuman.new(gets("Name:").chop)
    else
        p2=PlayerAI.new("AI-2")
    end
    p2.symbol="O"
	p1.otherSymbol=p2.symbol if p1.is_ai?
	p2.otherSymbol=p1.symbol if p2.is_ai?
    TicTacToe::Game.new(p1,p2)
end
start