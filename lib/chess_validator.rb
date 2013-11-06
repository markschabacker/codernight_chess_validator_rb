require_relative 'board_parser'

class ChessValidator
  def initialize(board_text)
    self.board = BoardParser.new.parse_board(board_text)
  end

  def validate(move)
    # rough idea
    # 1. look up piece on board
    # 2. ask piece if move is valid (passing board)
    # 3. verify that we are not in check
    #   - Ask all other opposing pieces if they can reach king?
    true
  end

private
  attr_accessor :board
end
