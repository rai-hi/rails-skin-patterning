# frozen_string_literal: true

class GridPrinter
  def self.print(grid)
    grid_as_string(grid).each { |row| puts row }
  end

  def self.grid_as_string(grid)
    grid.values.map do |row|
      row_output = row.map do |value|
        value.positive? ? '[0]' : '[ ]'
      end.join ''
      row_output
    end
  end
end
