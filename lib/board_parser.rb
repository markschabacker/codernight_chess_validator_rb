require_relative 'board'
require_relative 'piece_factory'

class BoardParser

  def initialize(piece_factory = PieceFactory.new)
    self.piece_factory = piece_factory
  end

  def parse_board(text_board)
    pieces = text_board.split.map { |token| piece_factory.piece_from_string(token) }
    Board.new(pieces)
  end

private
  attr_accessor :piece_factory
end
