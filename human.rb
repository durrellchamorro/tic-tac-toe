require './player'

class Human < Player
  def mark(board)
    coordinate = obtain_position
    board.mark(coordinate[0], coordinate[1], marker)
  end

  private

  def obtain_position
    puts "Pick an empty square"
    position = gets.strip.to_i
    get_position unless (1..9).include? position
    current_positions << position
    POSITIONS[position]
  end
end