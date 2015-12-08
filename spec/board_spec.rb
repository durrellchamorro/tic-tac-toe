require 'spec_helper'
require './board'

describe Board do

  let(:board) {Board.new}

  describe "#initialize" do
    it "creates an empty board" do
      expect(board.positions).to eq(Matrix[ [1,2,3], [4,5,6], [7,8,9]])
    end

    it "does not create a board with used positions" do
      expect(board.positions).not_to eq(Matrix[ [1,'x',3], [4,5,6], [7,8,9]])
    end
  end

  describe '#mark' do
    it "marks the board when given correct data" do
      board.mark(0, 0, 'x')

      expect(board.positions).to eq(Matrix[ ['x',2,3], [4,5,6], [7,8,9]])
    end

    it "can mark every position" do
      board.mark(0, 0, 'x')
      board.mark(0, 1, 'o')
      board.mark(0, 2, 'x')
      board.mark(1, 0, 'o')
      board.mark(1, 1, 'x')
      board.mark(1, 2, 'o')
      board.mark(2, 0, 'x')
      board.mark(2, 1, 'o')
      board.mark(2, 2, 'x')

      expect(board.positions).to eq(Matrix[ ['x','o','x'], ['o','x','o'], ['x','o','x']])
    end
  end

  describe '#game_over?' do
    context "when the game is over" do
      it "returns true when there is a forward diagonal win" do
        board.positions = Matrix[ ['x',2,3], [4,'x',6], [7,8,'x']]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ ['o',2,3], [4,'o',6], [7,8,'o']]
        expect(board.game_over?).to eq(true)
      end

      it "returns true when there is a reverse diagonal win" do
        board.positions = Matrix[ [1,2,'x'], [4,'x',6], ['x',8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,'o'], [4,'o',6], ['o',8, 9]]
        expect(board.game_over?).to eq(true)
      end

      it "returns true when x has a vertical win" do
        board.positions = Matrix[ ['x',2,3], ['x',5,6], ['x',8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,'x',3], [4,'x',6], [7,'x', 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,'x'], [4,5,'x'], [7,8, 'x']]
        expect(board.game_over?).to eq(true)
      end

      it "returns true when o has a vertical win" do
        board.positions = Matrix[ ['o',2,3], ['o',5,6], ['o',8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,'o',3], [4,'o',6], [7,'o', 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,'o'], [4,5,'o'], [7,8, 'o']]
        expect(board.game_over?).to eq(true)
      end

      it "returns true when x has a horizontal win" do
        board.positions = Matrix[ ['x','x','x'], [4,5,6], [7,8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,3], ['x','x','x'], [7,8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,3], [4,5,6], ['x','x', 'x']]
        expect(board.game_over?).to eq(true)
      end

      it "returns true when o has a horizontal win" do
        board.positions = Matrix[ ['o', 'o', 'o'], [4,5,6], [7,8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,3], ['o', 'o', 'o'], [7,8, 9]]
        expect(board.game_over?).to eq(true)

        board.positions = Matrix[ [1,2,3], [4,5,6], ['o', 'o', 'o']]
        expect(board.game_over?).to eq(true)
      end

      it "returns true when there is a tie" do
        create_a_tied_board(board)

        expect(board.game_over?).to eq(true)
      end
    end

    context "when the game is not over" do
      it "returns false when the game is not over" do
       board.positions = Matrix[ [1,2,3], ['x',5,6], ['o', 'o', 9]]

       expect(board.game_over?).to eq(false)
      end
    end
  end

  describe '#winner?' do
    context 'when there is no winner' do

      it 'returns false when there is a tie' do
        create_a_tied_board(board)

        expect(board.winner?('x')).to eq(false)
        expect(board.winner?('o')).to eq(false)
      end

      it 'returns false when there is no tie' do
        board.positions = Matrix[ [1,'x',3], [4,5,6], ['o',8, 9]]

        expect(board.winner?('x')).to eq(false)
        expect(board.winner?('o')).to eq(false)
      end
    end

    context 'when there is a winner' do

      it 'returns true when there is a reverse diagonal win' do
        board.positions = Matrix[ [1,2,'x'], [4,'x',6], ['x',8, 9]]
        expect(board.winner?('x')).to eq(true)
      end

      it 'returns true when there is a forward diagonal win' do
        board.positions = Matrix[ ['o',2,3], [4,'o',6], [7,8,'o']]
        expect(board.winner?('o')).to eq(true)
      end

      it 'returns true when there is a vertical win' do
        board.positions = Matrix[ ['o',2,3], ['o',5,6], ['o',8, 9]]
        expect(board.winner?('o')).to eq(true)

        board.positions = Matrix[ [1,'o',3], [4,'o',6], [7,'o', 9]]
        expect(board.winner?('o')).to eq(true)

        board.positions = Matrix[ [1,2,'o'], [4,5,'o'], [7,8, 'o']]
        expect(board.winner?('o')).to eq(true)
      end

      it 'returns true when there is a horizontal win' do
        board.positions = Matrix[ ['x','x','x'], [4,5,6], [7,8, 9]]
        expect(board.winner?('x')).to eq(true)

        board.positions = Matrix[ [1,2,3], ['x','x','x'], [7,8, 9]]
        expect(board.winner?('x')).to eq(true)

        board.positions = Matrix[ [1,2,3], [4,5,6], ['x','x', 'x']]
        expect(board.winner?('x')).to eq(true)
      end
    end
  end

  describe '#available_positions' do
    it 'returns an empty array if there are no available positions' do
      create_full(board, 'x')

      expect(board.available_positions).to eq([])
    end

    it 'returns an array of integers according to the positions that are available' do
      board.positions = Matrix[ [1,'x','x'], ['x','x','x'], ['x','x','x'] ]
      expect(board.available_positions).to eq([1])

      board.positions = Matrix[ [1, 2,'x'], ['x','x','x'], ['x','x','x'] ]
      expect(board.available_positions).to eq([1, 2])
    end
  end

  describe '#tie?' do
    it 'returns true if the board is full and there is no winner' do
      create_a_tied_board(board)

      expect(board.tie?).to eq(true)
    end

    it 'returns false if the board is full and there is a winner' do
      board.positions = Matrix[ ['x', 'x', 'x'], ['o', 'o', 'x'], ['x', 'o', 'x'] ]

      expect(board.tie?).to eq(false)
    end

    it 'returns false if there is a winner' do
      board.positions = Matrix[ ['o',2,3], [4,'o',6], [7,8,'o']]

      expect(board.tie?).to eq(false)
    end
  end

  def create_full(board, mark)
    board.positions = Matrix[ [mark, mark, mark], [mark, mark, mark], [mark, mark, mark] ]
  end

  def create_a_tied_board(board)
    board.positions = Matrix[ ['x', 'x', 'o'], ['o', 'o', 'x'], ['x', 'o', 'x'] ]
  end

  describe '#clear!' do
    it 'deletes all the marks on the board' do
      board.positions = Matrix[ ['x', 'x', 'x'], ['o', 'o', 'x'], ['x', 'o', 'x'] ]
      board.clear!

      expect(board.positions).to eq(Matrix[ [1,2,3], [4,5,6], [7, 8, 9]])
    end
  end
end