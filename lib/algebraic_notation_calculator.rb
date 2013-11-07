class AlgebraicNotationCalculator

  def initialize(source_coords)
    set_file_and_rank(source_coords)
  end

  def calculate_offset(file_offset, rank_offset)
    combine_file_and_rank(offset_file(file, file_offset),
                          offset_rank(rank, rank_offset))
  end

private
  attr_accessor :file, :rank

  def set_file_and_rank(combined_coords)
    self.file = combined_coords[0]
    self.rank = combined_coords[1].to_i
  end

  def combine_file_and_rank(file, rank)
    "#{file}#{rank}"
  end

  def offset_file(source_file, offset)
    (source_file.ord + offset).chr
  end

  def offset_rank(source_rank, offset)
    (source_rank + offset).to_s(16)
  end
end
