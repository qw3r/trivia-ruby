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

  end

end