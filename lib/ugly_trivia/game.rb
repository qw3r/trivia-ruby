module UglyTrivia
  class Game

    def initialize
      @players = []
      @places = Array.new(6, 0)
      @purses = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)

      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []

      @current_player = 0
      @is_getting_out_of_penalty_box = false

      create_questions
    end



    def add(player_name)
      @players.push player_name
      @places[number_of_players] = 0
      @purses[number_of_players] = 0
      @in_penalty_box[number_of_players] = false

      puts "#{player_name} was added"
      puts "They are player number #{number_of_players}"

      true
    end



    def roll(roll)
      puts "\n#{@players[@current_player]} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        if roll % 2 != 0
          @is_getting_out_of_penalty_box = true

          puts "#{@players[@current_player]} is getting out of the penalty box"
          step(roll)
        else
          puts "#{@players[@current_player]} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
        end

      else

        step(roll)
      end
    end



    def was_correctly_answered
      if @in_penalty_box[@current_player]
        if @is_getting_out_of_penalty_box
          puts 'Answer was correct!!!!'
          @purses[@current_player] += 1
          puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."

          winner = player_is_still_playing
          next_player

          winner
        else
          next_player

          true
        end


      else
        puts "Answer was corrent!!!!"
        @purses[@current_player] += 1
        puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."

        winner = player_is_still_playing
        next_player

        winner
      end
    end



    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{@players[@current_player]} was sent to the penalty box"
      @in_penalty_box[@current_player] = true

      next_player
      return true
    end



    private

    def create_questions
      50.times do |i|
        @pop_questions.push "Pop Question #{i}"
        @science_questions.push "Science Question #{i}"
        @sports_questions.push "Sports Question #{i}"
        @rock_questions.push "Rock Question #{i}"
      end
    end



    def number_of_players
      @players.length
    end



    def step(roll)
      @places[@current_player] = @places[@current_player] + roll
      @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11

      puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
      puts "The category is #{current_category}"
      ask_question
    end



    private

    def is_playable?
      number_of_players >= 2
    end



    def ask_question
      puts @pop_questions.shift if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift if current_category == 'Sports'
      puts @rock_questions.shift if current_category == 'Rock'
    end



    def current_category
      return 'Pop' if @places[@current_player] == 0
      return 'Pop' if @places[@current_player] == 4
      return 'Pop' if @places[@current_player] == 8
      return 'Science' if @places[@current_player] == 1
      return 'Science' if @places[@current_player] == 5
      return 'Science' if @places[@current_player] == 9
      return 'Sports' if @places[@current_player] == 2
      return 'Sports' if @places[@current_player] == 6
      return 'Sports' if @places[@current_player] == 10
      return 'Rock'
    end



    def next_player
      @current_player += 1
      @current_player = 0 if @current_player == number_of_players
    end



    def player_is_still_playing
      !(@purses[@current_player] == 6)
    end
  end
end
