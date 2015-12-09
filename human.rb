require './player'

class Human < Player
  def mark(board)
    coordinate = compute_coordinate_of_position(board)
    board.mark(coordinate[0], coordinate[1], marker)
  end

  private

  def compute_coordinate_of_position(board)
    position = obtain_position_from_human
    if (1..9).include? position
      current_positions << position
      POSITIONS[position]
    else
      system 'clear'
      puts board
      obtain_position(board)
    end
  end

  def obtain_position_from_human
    ask_human_for_position
    gets.strip.to_i
  end

  def ask_human_for_position
    puts "Pick an empty square"
  end
end