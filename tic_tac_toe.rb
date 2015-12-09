require './board'
require './computer'
require './human'

class TicTacToe
  attr_accessor :human, :computer, :board

  def initialize
    @human = Human.new
    @computer = Computer.new
    @board = Board.new
  end

  def play
    ask_human_who_goes_first
    set_markers
    gameplay_loop
    ask_human_to_play_again
  end

  private

  def ask_human_who_goes_first
    system 'clear'
    puts "Let's play tic tac toe! Best of five games wins!"
    puts "Would you like to go first or second? Enter 1 or 2"
  end

  def obtain_turn_order_from_human
    gets.strip
  end

  def set_markers
    humans_choice = obtain_turn_order_from_human
    play until ['1', '2'].include? humans_choice
    if humans_choice == '1'
      human.marker = 'x'
      computer.marker = 'o'
    else
      human.marker = 'o'
      computer.marker = 'x'
    end
    system 'clear'
  end

  def gameplay_loop
    if human.marker == 'x'
      take_turns_in_order(human, computer)
    else
      take_turns_in_order(computer, human)
    end
    run_post_game_tasks
  end

  def take_turns_in_order(player1, player2)
    [player1, player2].cycle do |player|
      puts board
      mark_board(player)
      system 'clear'
      announce_outcome(player.marker)
      break if game_over?
    end
  end

  def run_post_game_tasks
    record_score
    display_score
    clear_board
    clear_each_players_current_positions
    display_best_of_five_games_winner_if_winner_exists
    delete_all_wins_if_five_games_winner_exists
  end

  def record_score
    human.wins += 1 if board.winner?(human.marker)
    computer.wins += 1 if board.winner?(computer.marker)
  end

  def display_score
    puts "Total wins:"
    puts "You: #{human.wins}"
    puts "Computer: #{computer.wins}"
  end

  def clear_board
    board.clear!
  end

  def clear_each_players_current_positions
    human.current_positions = []
    computer.current_positions = []
  end

  def display_best_of_five_games_winner_if_winner_exists
    announce_best_of_five_games_winner if best_of_five_games_winner
  end

  def announce_best_of_five_games_winner
    if best_of_five_games_winner == computer
      puts "Computer won the best of five games!"
    else
      puts "You won the best of five games!"
    end
  end

  def best_of_five_games_winner
    return human if human.wins == 3
    return computer if computer.wins == 3
  end

  def delete_all_wins_if_five_games_winner_exists
    delete_all_wins if best_of_five_games_winner
  end

  def delete_all_wins
    human.wins = 0 && computer.wins = 0
  end

  def mark_board(player)
    if player.class == Computer
      player.mark(board, human)
    else
      player.mark(board)
    end
  end

  def announce_outcome(marker)
    announce_if_winner(marker)
    announce_if_tie_game
  end

  def announce_if_winner(marker)
    return unless board.winner?(marker)
    puts board
    puts "#{marker} wins!"
  end

  def announce_if_tie_game
    return unless board.tie?
    puts board
    puts "Tie game."
  end

  def game_over?
    board.game_over?
  end

  def obtain_humans_choice_about_playing_again
    gets.strip.downcase
  end

  def ask_human_to_play_again
    puts "Press enter to play again or enter 'q' to quit."
    if obtain_humans_choice_about_playing_again == 'q'
      system 'clear'
      puts "Good bye"
      exit
    else
      play
    end
  end
end

TicTacToe.new.play