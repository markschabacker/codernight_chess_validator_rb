require_relative 'piece_base'
require_relative 'piece_empty'
require_relative 'piece_pawn'

class PieceFactory
  def piece_from_string(piece_string)
    color_char = piece_string[0]
    piece_char = piece_string[1]
    piece_map[piece_char].new(color_char)
  end

private

  def piece_map
    piece_map = Hash.new(PieceEmpty)
    piece_map["P"] = PiecePawn
    piece_map["R"] = PieceRook
    piece_map["N"] = PieceKnight
    piece_map["B"] = PieceBishop
    piece_map["Q"] = PieceQueen
    piece_map["K"] = PieceKing

    piece_map
  end
end
