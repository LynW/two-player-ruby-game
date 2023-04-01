class MathGame
  def initialize
    @players = []
    @players << Player.new("Player1")
    @players << Player.new("Player2")
    @current_player = @players[0]
  end

  def generate_question
    num1 = rand(1..20)
    num2 = rand(1..20)
    operator = [:+, :-, :*].sample
    answer = num1.send(operator, num2)
    question = "#{num1} #{operator.to_s} #{num2}"
    [question, answer]
  end
  
  def change_turn
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def game_over?
    @players.any? { |player| player.lives <= 0 }
  end

  def play_turn
    puts "----- NEW TURN -----"
    question, answer = generate_question
    puts "#{@current_player.name}: #{question}"
    user_answer = gets.chomp.to_i
    if user_answer == answer
      puts "Correct!"
    else
      @current_player.lose_life
    end
    change_turn
  end

  def play_game
    until game_over?
      play_turn
    end
    winner = @players.detect { |player| player.lives > 0 }
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts "Good bye!"
  end
end