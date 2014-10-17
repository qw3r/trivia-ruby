module UglyTrivia
  class Game
    COINS_REQUIRED_TO_WIN = 6

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
        if roll % 2 == 0
          puts "#{@players[@current_player]} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false

          return
        end

        @is_getting_out_of_penalty_box = true
        puts "#{@players[@current_player]} is getting out of the penalty box"
      end

      step(roll)

      ask_question
    end



    def was_correctly_answered
      return true if (@in_penalty_box[@current_player] && !@is_getting_out_of_penalty_box)


      reward_correct_answer
    end



    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{@players[@current_player]} was sent to the penalty box"
      @in_penalty_box[@current_player] = true
    end



    def next_player
      @current_player += 1
      @current_player = 0 if @current_player == number_of_players
    end




    def is_finished?
      @purses.max >= COINS_REQUIRED_TO_WIN
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
    end



    def is_playable?
      number_of_players >= 2
    end



    def ask_question
      current_category = determine_current_category

      puts "The category is #{current_category}"

      case current_category
        when 'Pop'
          puts @pop_questions.shift
        when 'Science'
          puts @science_questions.shift
        when 'Sports'
          puts @sports_questions.shift
        when 'Rock'
          puts @rock_questions.shift
      end
    end



    def determine_current_category
      case @places[@current_player]
        when 0, 4, 8
          'Pop'
        when 1, 5, 9
          'Science'
        when 2, 6, 10
          'Sports'
        else
          'Rock'
      end
    end



    def reward_correct_answer
      puts "Answer was correct!!!!"
      @purses[@current_player] += 1
      puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."
    end

  end
end
