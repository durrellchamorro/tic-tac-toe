require './player'

class Computer < Player
  attr_reader :board

  def initialize(board)
    @board = board
    super()
  end

  def mark(human)
    position = pick_position(human, board.available_positions)
    coordinate = POSITIONS[position]
    current_positions << position
    board.mark(coordinate[0], coordinate[1], marker)
  end

  private

  def pick_position(human, available_positions)
    sleep 1
    pick_to_win || pick_to_defend(human) ||
      pick_position_five || available_positions.sample
  end

  def pick_position_five
    board.available_positions.include?(5) ? 5 : false
  end

  def pick_to_win
    compute_preferred_positions(self).sample
  end

  def pick_to_defend(human)
    compute_preferred_positions(human).sample
  end

  def compute_preferred_positions(player)
    winning_positions = WINNING_POSITIONS.map do |winning_position, pairs_of_neighbor_positions|
      winning_position if current_positions_equal_any?(pairs_of_neighbor_positions, player)
    end.compact
    select_available_positions_from(winning_positions)
  end

  def current_positions_equal_any?(pairs_of_neighbor_positions, player)
    pairs_of_neighbor_positions.any? { |pair| pair == current_positions_in(pair, player) }
  end

  def current_positions_in(pair_of_neighbor_positions, player)
    if pair_of_neighbor_positions - player.current_positions == []
      pair_of_neighbor_positions
    else
      false
    end
  end

  def select_available_positions_from(winning_positions)
    winning_positions & board.available_positions
  end
end