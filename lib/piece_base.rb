class PieceBase
  attr_reader :color

  def initialize(color)
    self.color = color
  end

private
  attr_writer :color
end

class PieceEmpty < PieceBase
end

class PiecePawn < PieceBase
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
