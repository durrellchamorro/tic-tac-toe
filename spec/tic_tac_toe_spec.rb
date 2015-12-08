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

  describe '#play' do
    it 'asks the human who goes first' do
      game = TicTacToe.new
      allow(game).to receive(:obtain_turn_order_from_human).and_return '1'
      expect_any_instance_of(Human).to receive(:obtain_position_from_human).and_return 1
      expect_any_instance_of(Computer).to receive(:pick_position).and_return 5
      expect_any_instance_of(Human).to receive(:obtain_position_from_human).and_return 2
      expect_any_instance_of(Computer).to receive(:pick_position).and_return 8
      expect_any_instance_of(Human).to receive(:obtain_position_from_human).and_return 3
      expect_any_instance_of(Board).to receive(:positions).and_return Matrix[['x', 'x', 'x'], [4,'o',6], [7,'o',9]]
      allow(game).to receive(:obtain_humans_choice_about_playing_again).and_return 'q'

      expect { game.play }.to output("ye").to_stdout
    end
  end
end