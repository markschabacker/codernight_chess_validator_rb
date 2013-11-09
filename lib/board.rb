require_relative 'piece_empty'

class Board
  def initialize(piece_array)
    self.pieces = convert_array_into_algebraic_notation_hash(piece_array)
  end

  def initialize_copy(source)
    super
    self.pieces = pieces.clone unless pieces.nil?
  end

  def piece_at(algebraic_position)
    pieces[algebraic_position]
  end

  def king_coords(color)
    pieces.select { |k,v| !v.nil? && v.check_target? && v.color == color }.first[0]
  end

  def after_move(source_coords, target_coords)
    next_board = self.clone

    source_piece = next_board.piece_at(source_coords)
    next_board.pieces[target_coords] = source_piece
    next_board.pieces[source_coords] = PieceEmpty.new

    next_board
  end

protected
  attr_accessor :pieces

private
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
