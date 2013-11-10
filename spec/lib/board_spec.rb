require_relative "../../lib/board"

describe Board do
  it "can be instantiated" do
    pieces = []
    Board.new(pieces).should_not be_nil
  end

  let (:fake_board_array) {
    ("a8 b8 c8 d8 e8 f8 g8 h8\n" +
     "a7 b7 c7 d7 e7 f7 g7 h7\n" +
     "a6 b6 c6 d6 e6 f6 g6 h6\n" +
     "a5 b5 c5 d5 e5 f5 g5 h5\n" +
     "a4 b4 c4 d4 e4 f4 g4 h4\n" +
     "a3 b3 c3 d3 e3 f3 g3 h3\n" +
     "a2 b2 c2 d2 e2 f2 g2 h2\n" +
     "a1 b1 c1 d1 e1 f1 g1 h1"
    ).split()
  }

  it "places pieces in algebraic chess notation locations (full)" do
    board = Board.new(fake_board_array)

    fake_board_array.each do |position|
      board.piece_at(position).should == position
    end
  end

  it "places pieces in algebraic chess notation locations (partial)" do
    expected_a8 = :expected_a8
    board = Board.new([expected_a8])

    board.piece_at("a8").should == expected_a8
    board.piece_at("b8").should be_nil
  end

  it "can find the king for a particular color" do
    color = "b"
    incorrect_color = "w"
    incorrect_king = double(:piece, :check_target? => true, :color => incorrect_color )
    non_king = double(:piece, :color => color, :check_target? => false)
    correct_king = double(:piece, :check_target? => true, :color => color )

    pieces = [ non_king, incorrect_king, correct_king, non_king ]
    board = Board.new(pieces)

    board.king_position(color).should == "c8"
  end

  describe "moving pieces" do
    let(:piece_a8) { :piece_a8 }
    let(:piece_b8) { :piece_b8 }
    let(:board) { Board.new([piece_a8, piece_b8]) }

    it "does not affect the current board" do
      board.after_move("a8", "b8")

      board.piece_at("a8").should == piece_a8
      board.piece_at("b8").should == piece_b8
    end

    it "moves pieces in the returned board" do
      out_board = board.after_move("a8", "b8")

      out_board.piece_at("b8").should == piece_a8
      out_board.piece_at("a8").should be_kind_of(PieceEmpty)
    end
  end

  describe "check state validation" do
    let (:white) { "w" }
    let (:black) { "b" }
    let (:white_king) { double(:piece_king, :color => white, :check_target? => true) }
    let (:white_king_pos) { "a8" }
    let (:other_piece) { double(:piece_other, :color => black) }
    let (:other_piece_pos) { "b8" }

    it "returns false if no opposing pieces have valid moves to the color's king (no opposing pieces)" do
      pieces = [ white_king ]
      board = Board.new(pieces)
      board.in_check?(white).should be_false
    end

    it "returns false if no opposing pieces have valid moves to the color's king (opposing piece not valid)" do
      pieces = [ white_king, other_piece ]
      board = Board.new(pieces)

      other_piece.should_receive(:validate_move).with(other_piece_pos, white_king_pos, board) { false }

      board.in_check?(white).should be_false
    end

    it "returns true if any opposing pieces has valid moves to the color's king" do
      pieces = [ white_king, other_piece ]
      board = Board.new(pieces)

      other_piece.should_receive(:validate_move).with(other_piece_pos, white_king_pos, board) { true }

      board.in_check?(white).should be_true
    end
  end
end
