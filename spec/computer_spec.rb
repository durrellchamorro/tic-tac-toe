require 'spec_helper'
require './board'
require './computer'
require './human'

describe Computer do
  it { expect(Computer).to be < Player }

  describe '#mark' do
    let(:board) { Board.new }
    let(:agent_smith) { Computer.new }
    let(:neo) { Human.new }

    before do
      agent_smith.marker = 'x'
      neo.marker = 'o'
    end

    it 'appends the marked position to the current_positions list' do
      allow(agent_smith).to receive(:pick_position).and_return 1
      agent_smith.mark(board, neo)
      expect(agent_smith.current_positions).to eq([1])

      allow(agent_smith).to receive(:pick_position).and_return 9
      agent_smith.mark(board, neo)
      expect(agent_smith.current_positions).to eq([1, 9])
    end

    context 'when empty board' do
      it 'it doesnt mark a position other than position five' do
        agent_smith.mark(board, neo)

        expect(board.available_positions.include?(5)).not_to eq(true)
      end

      it 'it marks position five' do
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ [1, 2, 3], [4, 'x', 6], [7, 8, 9]])
      end
    end

    context 'when position five is filled and there are no offensive or defensive moves' do
      it 'it marks a random posiiton' do
        board.positions = Matrix[ [1, 2, 3], [4, 'o', 6], [7, 8, 9]]
        agent_smith.mark(board, neo)

        expect(board.available_positions.size).to eq(7)
      end
    end

    context 'when position five is not filled and there are no offensive or defensive moves' do
      it 'it marks position five' do
        board.positions = Matrix[ ['o', 2, 3], [4, 5, 6], [7, 8, 9]]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['o', 2, 3], [4, 'x', 6], [7, 8, 9]])
      end
    end

    context 'when computer has two in a row' do
      it 'then it marks to get three in a row' do
        board.positions = Matrix[ ['x', 'x', 3], [4,5,6], [7,8,9]]
        agent_smith.current_positions = [1, 2]
        neo.current_positions = []
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['x','x','x'], [4,5,6], [7,8,9]])
      end

      it 'then it marks to get three in a row given a different pair of positions' do
        board.positions = Matrix[ [1, 2, 'x'], [4,5,'x'], [7,8,9]]
        agent_smith.current_positions = [3, 6]
        neo.current_positions = []
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ [1, 2, 'x'], [4,5,'x'], [7,8,'x']])
      end

      it 'then it marks to get three in a row given a different pair of positions' do
        board.positions = Matrix[ ['x', 2, 3], [4,'x',6], [7,8,9]]
        agent_smith.current_positions = [1, 5]
        neo.current_positions = []
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['x', 2, 3], [4,'x',6], [7,8,'x']])
      end

      it 'then it marks to get three in a row given a different pair of positions' do
        board.positions = Matrix[ [1, 2, 'x'], [4,'x',6], [7,8,9]]
        agent_smith.current_positions = [3, 5]
        neo.current_positions = []
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ [1, 2, 'x'], [4,'x',6], ['x',8,9]])
      end
    end

    context 'when the human and the computer have two in a row' do
      it 'then it prefers marking to win over marking to defend' do
        board.positions = Matrix[ ['o', 'x', 3], ['o','x',6], [7,8,9]]
        agent_smith.current_positions = [2, 5]
        neo.current_positions = [1, 4]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['o', 'x', 3], ['o','x',6], [7,'x',9]])
      end

      it 'then it prefers marking to win over marking to defend given different positions' do
        board.positions = Matrix[ ['o', 'o', 3], ['x','x',6], [7,8,9]]
        agent_smith.current_positions = [4, 5]
        neo.current_positions = [1, 2]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['o', 'o', 3], ['x','x','x'], [7,8,9]])
      end
    end

    context 'when the human has two in a row and the computer does not have two in a row' do
      it 'blocks at least one of the humans winning lines' do
        board.positions = Matrix[ ['o', 'o', 3], ['x',5 ,6], [7, 8, 9] ]
        agent_smith.current_positions = [4]
        neo.current_positions = [1, 2]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['o', 'o', 'x'], ['x',5, 6], [7,8,9]])
      end

      it 'blocks at least one of the humans winning lines' do
        agent_smith.marker = 'o'
        neo.marker = 'x'
        board.positions = Matrix[ ['x', 'x', 3], [4, 5, 6], [7, 8, 'o'] ]
        agent_smith.current_positions = [9]
        neo.current_positions = [1, 2]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['x', 'x', 'o'], [4, 5, 6], [7, 8, 'o']])
      end

      it 'blocks at least one of the humans winning lines' do
        agent_smith.marker = 'o'
        neo.marker = 'x'
        board.positions = Matrix[ ['x', 'o', 3], ['x', 5, 6], ['o', 8, 'x'] ]
        agent_smith.current_positions = [2, 7]
        neo.current_positions = [1, 4, 9]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['x', 'o', 3], ['x', 'o', 6], ['o', 8, 'x'] ])
      end

      it 'blocks at least one of the humans winning lines given different positions' do
        board.positions = Matrix[ ['o', 2, 3], ['o',5 ,6], [7, 'x', 9] ]
        agent_smith.current_positions = [8]
        neo.current_positions = [1, 4]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['o', 2, 3], ['o',5 ,6], ['x', 'x', 9] ])
      end

      it 'blocks at least one of the humans winning lines given different positions' do
        board.positions = Matrix[ ['o', 2, 3], [4, 'o', 6], ['x', 8, 9] ]
        agent_smith.current_positions = [7]
        neo.current_positions = [1, 5]
        agent_smith.mark(board, neo)

        expect(board.positions).to eq(Matrix[ ['o', 2, 3], [4, 'o', 6], ['x', 8, 'x']])
      end
    end
  end
end