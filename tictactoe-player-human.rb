require_relative "tictactoe-player.rb"
class PlayerHuman < PlayerBase

    def initialize(name)
        super(name)
    end

    def getInput
        return super
    end

    def getPos
        loop do 
            input = self.getInput.to_i
            return input-1 if (1..9).include?(input)
        end
    end
end