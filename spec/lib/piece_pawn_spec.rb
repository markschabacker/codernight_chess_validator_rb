require_relative '../../lib/algebraic_notation_calculator'
require_relative "../../lib/piece_pawn"
require_relative "shared_examples_for_piece"

describe PiecePawn do
  it_behaves_like "a colored chess piece"
  it_behaves_like "a non-king chess piece"

  let (:no_contest_piece) {
    double(:piece, :requires_contest? => false)
  }

  let (:contesting_piece) {
    double(:piece, :requires_contest? => true)
  }

  let (:opponent_piece) {
    double(:piece, :requires_contest? => true, :can_be_taken_by? => true)
  }

  let(:empty_board) {
    double(:board, :piece_at => no_contest_piece)
  }

  let(:full_board) {
    double(:board, :piece_at => contesting_piece )
  }

  let(:next_board) {
    double(:board_after_move, :in_check? => false)
  }

  def calculate_offset(position, file_offset, rank_offset)
    AlgebraicNotationCalculator.new(position).calculate_offset(file_offset, rank_offset)
  end

  [ [ PiecePawn.new("w"), "d2",  1 ],
    [ PiecePawn.new("b"), "d7", -1 ] ].each do | pawn, start_pos, direction_mult |
    before do
      full_board.stub(:after_move) { next_board }
      empty_board.stub(:after_move) { next_board }
    end

    describe "#{pawn.color}" do
      it "can move one unoccupied space forward" do
        one_forward = calculate_offset(start_pos, 0, 1 * direction_mult)
        pawn.validate_move(start_pos, one_forward, empty_board).should be_true
      end

      it "can move two unoccupied spaces forward if it is at the starting rank" do
        two_forward = calculate_offset(start_pos, 0, 2 * direction_mult)
        pawn.validate_move(start_pos, two_forward, empty_board).should be_true
      end

      it "cannot move two unoccupied spaces forward if it is not at the starting rank" do
        one_forward = calculate_offset(start_pos, 0, 1 * direction_mult)
        three_forward = calculate_offset(start_pos, 0, 3 * direction_mult)
        pawn.validate_move(one_forward, three_forward, empty_board).should be_false
      end

      it "cannot move forward onto an opposing piece" do
        one_forward = calculate_offset(start_pos, 0, 1 * direction_mult)
        pawn.validate_move(start_pos, one_forward, full_board).should be_false
      end

      it "cannot move forward over an opposing piece when at the starting rank" do
        one_forward = calculate_offset(start_pos, 0, 1 * direction_mult)
        two_forward = calculate_offset(start_pos, 0, 2 * direction_mult)

        board = double(:board)
        board.stub(:piece_at) { no_contest_piece }
        board.stub(:piece_at).with(one_forward) { contesting_piece }

        pawn.validate_move(start_pos, two_forward, board).should be_false
      end

      it "cannot move backwards" do
        one_backward = calculate_offset(start_pos, 0, -1 * direction_mult)
        pawn.validate_move(start_pos, one_backward, empty_board).should be_false
      end

      [ -1, 1 ].each do |h_offset|
        it "cannot move horizontally (#{h_offset})" do
          one_horizontal = calculate_offset(start_pos, h_offset, 0)
          pawn.validate_move(start_pos, one_horizontal, empty_board).should be_false
        end
      end

      [ -1, 1 ].each do |h_offset|
        it "cannot move diagonally on a non-capture (#{h_offset})" do
          one_diagonal = calculate_offset(start_pos, h_offset, 1 * direction_mult)
          pawn.validate_move(start_pos, one_diagonal, empty_board).should be_false
        end
      end

      [ [ "left-forward", -1 ],
        [ "right-forward", 1 ] ].each do |move, h_offset|
        it "can move diagonally #{move} if it captures an opponent" do
          one_diagonal = calculate_offset(start_pos, h_offset, 1 * direction_mult)

          board = double(:board)
          board.stub(:piece_at).with(one_diagonal) { opponent_piece }
          board.stub(:after_move) { next_board }

          pawn.validate_move(start_pos, one_diagonal, board).should be_true
        end
      end
    end
  end
end
