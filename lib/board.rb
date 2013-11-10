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

  def king_position(color)
    kings = pieces.select { |k,v| !v.nil? && v.color == color && v.check_target? }
    kings.length == 0 ? nil : kings.first[0]
  end

  def after_move(source_position, target_position)
    next_board = self.clone

    source_piece = next_board.piece_at(source_position)
    next_board.pieces[target_position] = source_piece
    next_board.pieces[source_position] = PieceEmpty.new

    next_board
  end

  def in_check?(color)
    king_pos = self.king_position(color)
    pieces_with_check = pieces.select { |pos, piece| !piece.nil? && (piece.color != color) && piece.validate_move(pos, king_pos, self) }
    pieces_with_check.length > 0
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
