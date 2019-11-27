require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    def initialize(name)
        super(name)
        @gamestates={}
        @lastMove = -1
        @lastGamestate = []
    end

    def getInput
        return super
    end

    def write(field, msg="Player #{@name}")
        super(field, msg)
    end

    def loose()
        @gamestates[@lastGamestate].delete(@lastMove)
    end
    
    def snapshot(field)
        @lastGamestate = field
    	return false if @gamestates.has_key?(field)
        free=[]
        field.map.with_index{ |x, pos| free.push(pos) if x.eql?(" ")}
        @gamestates.store(field, free)
        return true
    end

    def evalPos(field)
        return @gamestates[field].sample unless @gamestates[field].empty?
        return rand(0..8)
    end

    def getPos(field)
        self.snapshot(field)
        @lastMove = self.evalPos(field)
        return @lastMove
    end
end