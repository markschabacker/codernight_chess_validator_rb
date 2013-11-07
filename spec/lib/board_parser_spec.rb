require_relative '../../lib/board_parser'

describe "The Board Parser" do
  let (:piece_factory) { double(:piece_factory) }

  it "can be instantiated without parameters" do
    BoardParser.new.should_not be_nil
  end

  it "can be instantated with a piece factory" do
    BoardParser.new(piece_factory).should_not be_nil
  end

  let (:parser) { BoardParser.new(piece_factory) }

  let (:fake_board) {
    "a8 b8 c8 d8 e8 f8 g8 h8\n" +
    "a7 b7 c7 d7 e7 f7 g7 h7\n" +
    "a6 b6 c6 d6 e6 f6 g6 h6\n" +
    "a5 b5 c5 d5 e5 f5 g5 h5\n" +
    "a4 b4 c4 d4 e4 f4 g4 h4\n" +
    "a3 b3 c3 d3 e3 f3 g3 h3\n" +
    "a2 b2 c2 d2 e2 f2 g2 h2\n" +
    "a1 b1 c1 d1 e1 f1 g1 h1"
  }

  describe "when reading the board input" do
    it "populates each location with piece factory results (read)" do

      fake_board.split.each do |token|
        piece_factory.should_receive(:piece_from_string).with(token)
      end

      Board.stub(:new)

      parser.parse_board(fake_board)
    end

    it "returns a board instantiated with the piece factory results" do

      fake_board.split.each do |token|
        piece_factory.stub(:piece_from_string).with(token).and_return(token)
      end

      out_board = double(:board)
      Board.should_receive(:new) do |parsed_pieces|
        parsed_pieces.should == fake_board.split()
        out_board
      end

      parser.parse_board(fake_board).should == out_board
    end
  end
end
