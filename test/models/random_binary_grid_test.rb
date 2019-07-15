# frozen_string_literal: true

require 'test_helper'

class RandomBinaryGridTest < MiniTest::Test
  def setup
    @default_grid = RandomBinaryGrid.generate
    @another_grid = RandomBinaryGrid.generate
  end

  def test_returns_a_grid
    assert @default_grid.class == Grid
  end

  def test_returns_a_valid_grid
    assert @default_grid.valid?
  end

  def test_contains_multiple_values
    assert @default_grid.values.flatten.uniq.size > 1
  end

  def test_multiple_calls_return_different_grids
    refute_equal @default_grid.values, @another_grid.values
  end

  def test_all_rows_arent_identical
    assert @default_grid.values.uniq.size > 1
  end
end
