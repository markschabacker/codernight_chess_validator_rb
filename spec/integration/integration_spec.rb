require_relative '../../lib/chess_validator.rb'

describe "The Chess Validator" do
  let (:simple_board) {
"bR bN bB bQ bK bB bN bR\n" +
"bP bP bP bP bP bP bP bP\n" +
"-- -- -- -- -- -- -- --\n" +
"-- -- -- -- -- -- -- --\n" +
"-- -- -- -- -- -- -- --\n" +
"-- -- -- -- -- -- -- --\n" +
"wP wP wP wP wP wP wP wP\n" +
"wR wN wB wQ wK wB wN wR" }

  it "can be instantiated with a board" do
    ChessValidator.new(simple_board).should_not be_nil
  end

  describe "when validating moves" do
    let (:validator) { ChessValidator.new(simple_board) }

    ["a2 a3",
     "a2 a4",
     "a7 a6",
     "a7 a5",
     "b8 a6",
     "b8 c6",
     "e2 e3"].each do |move|
       it "can validate a legal move (#{move})" do
         validator.validate(move).should be_true
       end
     end

     ["a2 a5",
      "a7 a4",
      "a7 b6",
      "b8 d7",
      "e3 e2"].each do |move|
        it "can validate an illegal move (#{move})" do
          validator.validate(move).should be_false
        end
      end
  end

  it "can validate a valid pawn move that ends with a pawn in a check state" do

    board = "bR bN bB bQ bK bB bN bR\n" +
            "bP bP bP wP bP bP bP bP\n" +
            "-- -- -- -- -- -- -- --\n" +
            "-- -- -- -- -- -- -- --\n" +
            "-- -- -- -- -- -- -- --\n" +
            "-- -- -- -- -- -- -- --\n" +
            "wP wP wP -- wP wP wP wP\n" +
            "wR wN wB wQ wK wB wN wR"

    validator = ChessValidator.new(board)

    validator.validate("c7 c6").should be_false
  end
end
