class PlayerBase
    attr_reader :name
    attr_accessor :symbol

    protected
    def initialize(name)
        @name=name
        @symbol = ""
        @is_ai=false
    end

    public
    def getInput
        return gets.chomp
    end
    
    def is_ai?
    	return is_ai
    end

    def win()
        return
    end

    def loose()
        return
    end

    def draw()
        return
    end

    def write(field, msg="Player #{@name}")
        for i in 0..8 
            print "[#{field[i]}]"
            puts "" if ((i+1)%3).zero?
        end
        puts msg
    end
    
    def is_ai?
    	return false
    end

    def getPos(field)
        self.write(field)
        return rand(0..8)
    end
end