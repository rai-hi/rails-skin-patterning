# frozen_string_literal: true

require 'test_helper'

class GridPrinterTest < MiniTest::Test
  def test_grid_as_string_returns_correct_line_count
    grid = Grid.new [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1]
    ]

    assert_equal grid.height, GridPrinter.grid_as_string(grid).size
  end
end
