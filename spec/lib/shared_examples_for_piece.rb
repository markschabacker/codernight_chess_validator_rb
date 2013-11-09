shared_examples "a chess piece" do
  let(:piece) { described_class.new(:piece_color) }

  subject { piece }
  it { should respond_to(:validate_move) }
  it { should respond_to(:can_be_taken_by?) }
  it { should respond_to(:requires_contest?) }
  it { should respond_to(:check_target?) }
end

shared_examples "a colored chess piece" do
  it_behaves_like "a chess piece"

  let(:color) { "b" }
  let(:piece) { described_class.new(color) }

  it "stores its color" do
    piece.color.should == color
  end

  it "can be taken by a piece of another color" do
    piece.can_be_taken_by?(:other_color).should be_true
  end

   it "requires a contest" do
     piece.requires_contest?.should be_true
   end
end

shared_examples "a non-king chess piece" do
  let(:piece) { described_class.new(:piece_color) }

  it "is not a check target" do
    piece.check_target?.should be_false
  end
end
