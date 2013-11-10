require_relative 'algebraic_notation_calculator'

class PieceBase
  attr_reader :color

  def initialize(color)
    self.color = color
  end

  def validate_move(start_pos, finish_pos, current_board)
    if is_valid_before_check_check?(start_pos, finish_pos, current_board)
        next_board = current_board.after_move(start_pos, finish_pos)
        return !next_board.in_check?(self.color)
    end

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

  def is_valid_before_check_check?(start_pos, finish_pos, current_board)
    valid_move_criteria = get_valid_move_criteria(start_pos)
    position_criteria = valid_move_criteria[finish_pos]

    !position_criteria.nil? && position_criteria.call(current_board)
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
  def check_target?
    true
  end
end
