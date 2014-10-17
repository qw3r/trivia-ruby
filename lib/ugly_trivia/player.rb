module UglyTrivia

  class Player
    attr_accessor :coins, :position, :name



    def initialize(name)
      @name = name
      @coins = 0
      @position = 0
      @in_penalty = false
    end



    def in_penalty?
      @in_penalty
    end



    def in_penalty!
      @in_penalty = true
    end



    def step(roll)
      @position = @position + roll
      @position = @position - 12 if @position > 11
    end

  end

end