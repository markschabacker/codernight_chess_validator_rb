require_relative "../../lib/algebraic_notation_calculator"

describe AlgebraicNotationCalculator do

  let(:start_file) { "d" }
  let(:start_rank) { 4 }
  let (:start_coords) { "#{start_file}#{start_rank}" }
  let (:calculator) { AlgebraicNotationCalculator.new(start_coords) }

  describe "vertical offset" do
    [ [ 4, 8 ],
      [ 3, 7 ],
      [ 2, 6 ],
      [ 1, 5 ],
      [ 0, 4 ],
      [ -1, 3 ],
      [ -2, 2],
      [ -3, 1] ].each do | vert_offset, expected_rank |
        it "can calculate a vertical only offset (#{vert_offset})" do
          result = calculator.calculate_offset(0, vert_offset)
          result[1].should == expected_rank.to_s
        end
      end
  end

  describe "horizontal offset" do
    [ [ 4, "h" ],
      [ 3, "g" ],
      [ 2, "f" ],
      [ 1, "e" ],
      [ 0, "d" ],
      [ -1, "c" ],
      [ -2, "b"],
      [ -3, "a"] ].each do | horizontal_offset, expected_file |
        it "can calculate a horizontal only offset (#{horizontal_offset})" do
          result = calculator.calculate_offset(horizontal_offset, 0)
          result[0].should == expected_file
        end
      end
  end

  it "can calculate horizontal and vertical offsets" do
    result = calculator.calculate_offset(3, 2)
    result[0].should == "g"
    result[1].should == 6.to_s
  end

  [ [ "a8", 0, 7, "a", "f"],
    [ "a1", 0, -7, "a", "-"],
    [ "a1", -1, 0, '`', "1"],
    [ "h1", 1, 0, "i", "1"] ].each do |start_coord, h_offset, v_offset, file, rank|
      it "can calculate coordinates that run off the board" do
        result = AlgebraicNotationCalculator.new(start_coord).calculate_offset(h_offset, v_offset)
        result[0].should == file
        result[1].should == rank
      end
    end
end
