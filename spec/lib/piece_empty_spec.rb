require_relative "../../lib/piece_empty"
require_relative "shared_examples_for_piece"

describe PieceEmpty do
  it_behaves_like "a chess piece"

  let(:piece) { PieceEmpty.new(:whatever) }

  it "can be initialized without a color" do
    PieceEmpty.new.should_not be_nil
  end

  it "always returns false for validate_move" do
    piece.validate_move(nil, nil, nil).should be_false
  end

  it "always returns true for can_be_taken_by?" do
    piece.can_be_taken_by?(:empty).should be_true
  end

  it "always returns :empty for color" do
    piece.color.should == :empty
  end

   it "does not require a contest" do
     piece.requires_contest?.should be_false
   end
end
