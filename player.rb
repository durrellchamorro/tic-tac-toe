require './winning_positions_data'
require './positions_data'

class Player
  attr_accessor :marker, :current_positions, :wins, :board

  def initialize
    @current_positions = []
    @wins = 0
  end
end