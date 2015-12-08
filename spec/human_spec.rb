require 'spec_helper'
require './board'
require './human'

describe Human do
  it { expect(Human).to be < Player }

  let(:board1) { Board.new }
  let(:board2) { Board.new }
  let(:morpheus) { Human.new }

  describe '#mark' do
    before { morpheus.marker = 'x' }

    it 'marks the board with the correct marker in the correct position' do
      allow(morpheus).to receive(:obtain_position).and_return [0, 0]
      morpheus.mark(board1)
      expect(board1.positions).to eq(Matrix[ ['x',2,3], [4,5,6], [7,8,9]])
      expect(board1.positions).not_to eq(Matrix[ ['o',2,3], [4,5,6], [7,8,9]])


      allow(morpheus).to receive(:obtain_position).and_return [2, 1]
      morpheus.mark(board2)
      expect(board2.positions).to eq(Matrix[ [1,2,3], [4,5,6], [7,'x',9]])
      expect(board2.positions).not_to eq(Matrix[ [1,2,3], [4,5,6], [7,'o',9]])
    end

    it 'appends the marked position to the current_positions list' do
      allow(morpheus).to receive(:obtain_position).and_return [0, 0]
      morpheus.mark(board1)
      expect(morpheus.current_positions).to eq([1])

      allow(morpheus).to receive(:obtain_position).and_return [2, 2]
      morpheus.mark(board1)
      expect(morpheus.current_positions).to eq([1, 9])
    end
  end
end
