require_relative '../../lib/piece_factory'

describe "The Piece Factory" do
  it "can be instantiated" do
    PieceFactory.new.should_not be_nil
  end

  let (:piece_factory) { PieceFactory.new }

  describe "Parsing Pieces" do
    it "returns a piece" do
      black_pawn_string = "bP"
      piece_factory.piece_from_string(black_pawn_string).should_not be_nil
    end

    it "reads the color from the piece string" do
      expected_color = "z"
      piece_string = "#{expected_color}P"

      piece_factory.piece_from_string(piece_string).color.should == expected_color
    end

    [
      ["-", PieceEmpty ],
      ["P", PiecePawn],
      ["R", PieceRook],
      ["N", PieceKnight],
      ["B", PieceBishop],
      ["Q", PieceQueen],
      ["K", PieceKing],
    ]
      .each do |piece_char, piece_type|
      it "reads the piece type from the piece string (#{piece_char}, #{piece_type})" do
        piece_string = "b#{piece_char}"
        piece_factory.piece_from_string(piece_string).should be_kind_of(piece_type)
      end
    end
  end
end
