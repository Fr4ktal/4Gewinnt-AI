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

    def getPos
        return 0
    end
end