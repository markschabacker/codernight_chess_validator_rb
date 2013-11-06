class Board
  def initialize(piece_array)
    self.pieces = convert_array_into_algebraic_notation_hash(piece_array)
  end

  def piece_at(algebraic_position)
    pieces[algebraic_position]
  end

private
  attr_accessor :pieces

  def convert_array_into_algebraic_notation_hash(piece_array)
    piece_hash = {}

    8.downto(1).each do |vertical_index|
      "a".upto("h").each do |horizontal_index|
        algebraic_coords = "#{horizontal_index}#{vertical_index}"
        piece_hash[algebraic_coords] = piece_array.shift
      end
    end

    piece_hash
  end
end
