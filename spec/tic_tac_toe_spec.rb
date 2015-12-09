require 'spec_helper'
require './tic_tac_toe'
require './spec/custom/should_have_attr_accessor'

describe TicTacToe do
  it { expect(subject).to have_attr_accessor(:human) }
  it { expect(subject).to have_attr_accessor(:computer) }
  it { expect(subject).to have_attr_accessor(:board) }

  describe '#initialize' do
    it 'sets @human' do
      game = TicTacToe.new

      expect(game.human).to be_instance_of Human
    end

    it 'sets @computer' do
      game = TicTacToe.new

      expect(game.computer).to be_instance_of Computer
    end

    it 'sets @board' do
      game = TicTacToe.new

      expect(game.board).to be_instance_of Board
    end
  end
end