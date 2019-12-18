require_relative "tictactoe-player.rb"
class PlayerHuman < PlayerBase

    def initialize(name)
        super(name)
    end

    def getInput()
        return super()
    end

    def write(field, msg="Player #{@name}")
        super(field, msg)
    end

    def is_ai?()
    	return false
    end

    def getPos(field)
        write(field)
        loop do 
            input = self.getInput().to_i()
            return input-1 if (1..9).include?(input)
        end
    end
end