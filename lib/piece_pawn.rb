require_relative 'piece_base'

class PiecePawn < PieceBase

protected
  def get_valid_move_criteria(start_pos)
    calculator = get_calculator(start_pos)
    condition_proc_hash = {}

    one_forward_pos = calculator.calculate_offset(0, 1 * direction_multiplier)
    condition_proc_hash[one_forward_pos] = Proc.new{|board|
      !self.position_requires_contest?(one_forward_pos, board)
    }

    if is_starting_rank?(start_pos)
      two_forward_pos = calculator.calculate_offset(0, 2 * direction_multiplier)
      condition_proc_hash[two_forward_pos] = Proc.new{|board|
        condition_proc_hash[one_forward_pos].call(board) \
          && !self.position_requires_contest?(two_forward_pos, board)
      }
    end

    [-1, 1].each do |h_offset|
      diagonal = calculator.calculate_offset(h_offset, 1 * direction_multiplier)
      condition_proc_hash[diagonal] = Proc.new{|board|
        self.position_requires_contest?(diagonal, board) \
          && self.position_can_be_taken?(diagonal, board)
      }
    end

    condition_proc_hash
  end

private
  def is_starting_rank?(position)
    starting_rank = is_black? ? 7 : 2
    position[1] == starting_rank.to_s
  end

  def direction_multiplier
    is_black? ? -1 : 1
  end

  def is_black?
    #TODO: yuck, but this make board parsing easy
    color == "b"
  end
end
