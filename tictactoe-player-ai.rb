require_relative "tictactoe-player.rb"
class PlayerAI < PlayerBase

    def initialize(name)
        super(name)
        @gamestates={}
    end

    def getInput
        return super
    end

    def write(field)
        super(field)
    end
    
    def snapshot(field)
    	return if @gamestates.keys.includes?(field)
	    free=[]
    	field.map.with_index{ |x, pos| free.push(pos) if x.eql?(" ")}
    	@gamestates={field => free}
    end

    def getPos(field)
    	snapshot(field)
    	return rand(@gamestates[field]) unless @gamestates[field].size==0
    	return super(field)
    end
end