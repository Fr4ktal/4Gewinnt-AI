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

    def write(field)
        super(field)
    end

    def loose()
        @gamestates[@lastGamestate].delete(@lastMove)
    end
    
    def snapshot(field)
        @lastGamestate = field
    	return if @gamestates.keys.includes?(field)
	    free=[]
    	field.map.with_index{ |x, pos| free.push(pos) if x.eql?(" ")}
    	@gamestates={field => free}
    end

    def evalPos(field)
        return rand(@gamestates[field]) unless @gamestates[field].empty?
        return rand(0..8)
    end

    def getPos(field)
        snapshot(field)
        return @lastMove = evalPos(field)
    	return super(field)
    end
end