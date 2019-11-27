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
        retry
    end
end

def start
    if is_human?(1)
        p1=PlayerHuman.new(gets("Name:").chop)
    else
        p1=PlayerAI.new("AI-1")
    end
    if is_human?(2)
        p2=PlayerHuman.new(gets("Name:").chop)
    else
        p2=PlayerAI.new("AI-2")
    end
    Game.new(p1,p2)
end
start