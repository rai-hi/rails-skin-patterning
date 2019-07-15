# frozen_string_literal: true

require 'test_helper'

class GridConvoluterTest < MiniTest::Test
  def setup
    @original_grid = Grid.new [
      [1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1]
    ]

    @convolution_matrix = Grid.new [
      [2, 2, 2],
      [2, 1, 2],
      [2, 2, 2]
    ]

    @expected_convoluted = Grid.new [
      [ 7, 11, 11, 11,  7],
      [11, 17, 17, 17, 11],
      [11, 17, 17, 17, 11],
      [ 7, 11, 11, 11,  7]
    ]

    convoluter = GridConvoluter.new @convolution_matrix
    @convoluted_grid = convoluter.convolute @original_grid
  end

  def test_convolute_returns_grid
    assert_equal Grid, @convoluted_grid.class
  end

  def test_convolute_returns_new_grid_instance
    refute_equal @convoluted_grid, @original_grid
  end

  def test_convoluted_grid_has_the_same_height
    assert_equal @original_grid.height, @convoluted_grid.height
  end

  def test_convoluted_grid_has_the_same_width
    assert_equal @original_grid.width, @convoluted_grid.width
  end

  def test_convoluted_grid_is_valid
    assert @convoluted_grid.valid?
  end

  # Convolution matrixes must have odd widths, since it requires a central value
  # to represent the centre of the neighbourhood
  def test_throws_an_error_if_rule_isnt_odd_width
    assert_raises ConvolutionMatrixSizeError do
      odd_width_conv = Grid.new(
        [
          [1, 1, 1, 1],
          [1, 1, 1, 1],
          [1, 1, 1, 1]
        ]
      )
      GridConvoluter.new(odd_width_conv).convolute(@original_grid)
    end
  end

  # Convolution matrixes must have odd heights, since it requires a central
  # value to represent the centre of the neighbourhood
  def test_throws_an_error_if_rule_isnt_odd_height
    assert_raises ConvolutionMatrixSizeError do
      odd_height_conv = Grid.new(
        [
          [1, 1, 1],
          [1, 1, 1],
          [1, 1, 1],
          [1, 1, 1]
        ]
      )
      GridConvoluter.new(odd_height_conv).convolute(@original_grid)
    end
  end

  def test_values_match_expected
    assert_equal @expected_convoluted.values, @convoluted_grid.values
  end
end
