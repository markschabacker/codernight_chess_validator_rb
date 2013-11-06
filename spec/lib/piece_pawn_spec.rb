require_relative "../../lib/piece_base"
require_relative "shared_examples_for_piece"

describe PiecePawn do
  it_behaves_like "a colored chess piece"

  it "can move one unoccupied space forward"
  it "can move two unoccupied spaces forward if it is at the starting rank"

  ["left-forward", "right-forward"].each do |move|
    it "can move diagonally #{move} if it captures an opponent"
  end

  it "cannot jump pieces"
  it "cannot move backwards"
  it "cannot move horizontally"
  it "cannot move diagonally on a non-capture"
end
