require_relative 'piece_base'

class PieceEmpty < PieceBase
  def color
    :empty
  end

  def can_be_taken_by?(color)
    true
  end
end
