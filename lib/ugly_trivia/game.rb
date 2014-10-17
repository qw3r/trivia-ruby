require_relative './player'
require_relative './category'

module UglyTrivia
  class Game
    COINS_REQUIRED_TO_WIN = 6



    def initialize
      @players = []
      @current_players_index = 0
      @is_getting_out_of_penalty_box = false

      create_categories_and_question
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
      @current_players_index += 1
      @current_players_index = 0 if @current_players_index == number_of_players
    end



    def is_finished?
      @players.map(&:coins).max >= COINS_REQUIRED_TO_WIN
    end



    private


    def current_player
      @players[@current_players_index]
    end



    def create_categories_and_question
      @categories = {}

      %w[Pop Science Sports Rock].each do |category_name|
        category = Category.new(category_name)

        50.times { |i| category.add_question "#{category_name} Question #{i}" }

        @categories[category_name] = category
      end
    end



    def number_of_players
      @players.length
    end



    def step(roll)
      current_player.step roll

      puts "#{current_player.name}'s new location is #{current_player.position}"
    end



    def ask_question
      puts "The category is #{current_category.name}"
      puts current_category.next_question
    end



    def current_category
      @categories[category_of_the_current_position]
    end



    def category_of_the_current_position
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
      current_player.coins += current_category.value

      puts "Answer was correct!!!!"
      puts "#{current_player.name} now has #{current_player.coins} Gold Coins."
    end

  end
end
