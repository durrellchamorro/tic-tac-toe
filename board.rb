require 'Matrix'

class Board
  attr_accessor :positions

  def initialize
    create_empty_board
  end

  def mark(row, column, marker)
    positions.send(:[]=,row,column,marker)
  end

  def game_over?
    winner?('x') || winner?('o') || full?
  end

  def winner?(marker)
    diagonal_win?(marker) || vertical_win?(marker) || horizontal_win?(marker)
  end

  def available_positions
    positions.select { |position| position.class == Fixnum }
  end

  def tie?
    full? && !winner?('x') && !winner?('o')
  end

  def clear!
    self.positions = Matrix[[1,2,3], [4,5,6], [7, 8, 9]]
  end

  private

  def diagonal_win?(marker)
    reverse_diagonal = [positions[2,0], positions[1,1], positions[0,2]]
    forward_diagonal = [positions[0,0], positions[1,1], positions[2,2]]
    [marker, marker, marker] == reverse_diagonal ||
      [marker, marker, marker] == forward_diagonal
  end

  def vertical_win?(marker)
    positions.column(0).to_a == [marker, marker, marker] ||
      positions.column(1).to_a == [marker, marker, marker] ||
      positions.column(2).to_a == [marker, marker, marker]
  end

  def horizontal_win?(marker)
    positions.to_a.select { |row| row == [marker, marker, marker] }.any?
  end

  def full?
    !positions.any? { |position| position.class == Fixnum }
  end

  def to_s
    positions.to_a.map { |row| row.join(" ") }.join("\n")
  end

  def create_empty_board
    @positions = Matrix[[1,2,3], [4,5,6], [7,8,9]]
  end
end