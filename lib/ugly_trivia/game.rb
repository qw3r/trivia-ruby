require_relative './player'

module UglyTrivia
  class Game
    COINS_REQUIRED_TO_WIN = 6



    def initialize
      @players = []
      @current_player = 0

      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []

      @is_getting_out_of_penalty_box = false

      create_questions
    end



    def add(player_name)
      @players.push Player.new(player_name)

      puts "#{player_name} was added"
      puts "They are player number #{number_of_players}"
      true
    end



    def roll(roll)
      puts "\n#{current_player.name} is the current player"
      puts "They have rolled a #{roll}"

      if current_player.in_penalty?
        if roll % 2 == 0
          puts "#{current_player.name} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false

          return
        end

        @is_getting_out_of_penalty_box = true
        puts "#{current_player.name} is getting out of the penalty box"
      end

      step(roll)

      ask_question
    end



    def was_correctly_answered
      return true if (current_player.in_penalty? && !@is_getting_out_of_penalty_box)

      reward_correct_answer
    end



    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{current_player.name} was sent to the penalty box"
      current_player.in_penalty!
    end



    def next_player
      @current_player += 1
      @current_player = 0 if @current_player == number_of_players
    end



    def is_finished?
      @players.map(&:coins).max >= COINS_REQUIRED_TO_WIN
    end



    private


    def current_player
      @players[@current_player]
    end



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
      current_player.position = current_player.position + roll
      current_player.position = current_player.position - 12 if current_player.position > 11

      puts "#{current_player.name}'s new location is #{current_player.position}"
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
      case current_player.position
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
      current_player.coins += 1
      puts "#{current_player.name} now has #{current_player.coins} Gold Coins."
    end

  end
end
