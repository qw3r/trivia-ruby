module UglyTrivia


  class Category

    attr_reader :questions, :name, :value



    def initialize(name, value = 1)
      @name = name
      @questions = []
      @value = value
    end



    def add_question(question)
      @questions << question
    end



    def next_question
      @questions.shift
    end


  end
end