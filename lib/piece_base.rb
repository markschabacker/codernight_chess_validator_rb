require_relative 'algebraic_notation_calculator'

class PieceBase
  attr_reader :color

  def initialize(color)
    self.color = color
  end

  def validate_move(start_pos, finish_pos, current_board)
    valid_move_criteria = get_valid_move_criteria(start_pos)
    position_criteria = valid_move_criteria[finish_pos]

    unless position_criteria.nil?
      return position_criteria.call(current_board)
    end

    # TODO:
    # 1. Find opposing own king on board
    # 2. Determine if any opposing pieces have valid moves to to the king's position

    false
  end

  def requires_contest?
    true
  end

  def can_be_taken_by?(color)
    self.color != color
  end

  def check_target?
    false
  end

protected
  def get_valid_move_criteria(start_pos)
    {}
  end

  def get_calculator(position)
    AlgebraicNotationCalculator.new(position)
  end

  def position_requires_contest?(position, board)
      board.piece_at(position).requires_contest?
  end

  def position_can_be_taken?(position, board)
    board.piece_at(position).can_be_taken_by?(self.color)
  end

private
  attr_writer :color
end

class PieceRook < PieceBase
end

class PieceKnight < PieceBase
end

class PieceBishop < PieceBase
end

class PieceQueen < PieceBase
end

class PieceKing < PieceBase
end
