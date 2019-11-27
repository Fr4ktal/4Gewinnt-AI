class PlayerBase
    attr_reader :name

    protected
    def initialize(name)
        @name=name
    end

    public
    def getInput
        return gets.chomp
    end
    
    def is_ai?
    	return false
    end

    def getPos(field)
        return rand(0..8)
    end
end