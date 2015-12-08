require './player'

class Human < Player
  def mark(board)
    coordinate = obtain_position(board)
    board.mark(coordinate[0], coordinate[1], marker)
  end

  private

  def obtain_position(board)
    puts "Pick an empty square"
    position = gets.strip.to_i
    if (1..9).include? position
      current_positions << position
      POSITIONS[position]
    else
      system 'clear'
      puts board
      obtain_position(board)
    end
  end
end