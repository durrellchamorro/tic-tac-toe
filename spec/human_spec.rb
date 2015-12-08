require 'spec_helper'
require './board'
require './human'

describe Human do
  it { expect(Human).to be < Player }

  let(:board) { Board.new }
  let(:morpheus) { Human.new }

  describe '#mark' do
    before { morpheus.marker = 'x' }

    it 'marks the board with the humans mark in the correct position' do
      allow(morpheus).to receive(:obtain_position_from_human).and_return 1
      morpheus.mark(board)
      expect(board.positions).to eq(Matrix[ ['x',2,3], [4,5,6], [7,8,9]])
    end

    it 'does not mark the board in the correct position with the computers mark' do
      allow(morpheus).to receive(:obtain_position_from_human).and_return 1
      morpheus.mark(board)
      expect(board.positions).not_to eq(Matrix[ ['o',2,3], [4,5,6], [7,8,9]])
    end

    it 'marks the board with the humans mark in the correct position' do
      allow(morpheus).to receive(:obtain_position_from_human).and_return 8
      morpheus.mark(board)

      expect(board.positions).to eq(Matrix[ [1,2,3], [4,5,6], [7,'x',9]])
    end

    it 'does not mark the board in the correct position with the computers mark' do
      allow(morpheus).to receive(:obtain_position_from_human).and_return 8
      morpheus.mark(board)

      expect(board.positions).not_to eq(Matrix[ [1,2,3], [4,5,6], [7,'o',9]])
    end

    it 'appends the marked position to the current_positions list' do
      allow(morpheus).to receive(:obtain_position_from_human).and_return 1
      morpheus.mark(board)

      expect(morpheus.current_positions).to eq([1])

      allow(morpheus).to receive(:obtain_position_from_human).and_return 9
      morpheus.mark(board)

      expect(morpheus.current_positions).to eq([1, 9])
    end
  end
end
