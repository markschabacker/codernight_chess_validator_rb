require_relative 'piece_base'

class PieceEmpty < PieceBase
  def initialize(color = "-")
    super(color)
  end

  def color
    :empty
  end

  def validate_move(start_pos, finish_pos, current_board)
    false
  end

  def can_be_taken_by?(color)
    true
  end

  def requires_contest?
    false
  end
end
