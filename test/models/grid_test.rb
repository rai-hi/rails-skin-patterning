# frozen_string_literal: true

require 'test_helper'

class GridTest < MiniTest::Test
  def setup
    @valid_array = [
      [1, 0, 1],
      [1, 1, 1],
      [0, 0, 0],
      [0, 0, 0]
    ]
    @valid_grid = Grid.new(@valid_array)

    @invalid_size_array = [
      [1, 1],
      [1, 1, 1],
      [1, 1, 1, 1]
    ]

    @invalid_value_array = [
      ['a', 1],
      [1, 9]
    ]
  end

  def test_two_grids_with_equivalent_values_are_equal
    assert_equal @valid_grid, Grid.new(@valid_grid.values.clone)
  end

  def test_passed_array_is_set_to_values_attr
    assert @valid_grid.values == @valid_array
  end

  def test_can_be_instantiated_with_a_valid_size_array
    assert @valid_grid.valid?
  end

  def test_cannot_be_instantiated_with_an_invalid_sized_array
    assert Grid.new(@invalid_size_array).invalid?
  end

  def test_cannot_be_instantiated_with_an_empty_array
    assert Grid.new([]).invalid?
  end

  def test_cannot_be_instantiated_with_non_numeric_values
    assert Grid.new(@invalid_value_array).invalid?
  end

  def test_has_height_method
    assert @valid_grid.height == @valid_grid.values.size
  end

  def test_has_width_method
    assert @valid_grid.width == @valid_grid.values[0].size
  end
end
