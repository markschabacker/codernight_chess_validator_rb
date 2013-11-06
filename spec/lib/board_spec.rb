require_relative "../../lib/board"

describe Board do
  it "can be instantiated" do
    pieces = []
    Board.new(pieces).should_not be_nil
  end

  let (:fake_board_array) {
    ("a8 b8 c8 d8 e8 f8 g8 h8\n" +
     "a7 b7 c7 d7 e7 f7 g7 g7\n" +
     "a6 b6 c6 d6 e6 f6 g6 g6\n" +
     "a5 b5 c5 d5 e5 f5 g5 g5\n" +
     "a4 b4 c4 d4 e4 f4 g4 g4\n" +
     "a3 b3 c3 d3 e3 f3 g3 g3\n" +
     "a2 b2 c2 d2 e2 f2 g2 g2\n" +
     "a1 b1 c1 d1 e1 f1 g1 g1"
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
end
