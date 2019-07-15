# frozen_string_literal: true

require 'test_helper'

class GridPadderTest < MiniTest::Test
  def setup
    @non_padded_values = [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1]
    ]

    @non_padded_grid = Grid.new @non_padded_values

    @pad_height = 5
    @pad_width = 3
    @pad_value = 0

    @padder = GridPadder.new(
      pad_value: @pad_value, pad_width: @pad_width, pad_height: @pad_height
    )

    @padded = @padder.pad(@non_padded_grid)
    @depadded = @padder.depad(@padded)
  end

  def test_original_grid_is_unmodified_after_pad
    original = RandomBinaryGrid.generate
    original_values = original.values.clone
    @padder.pad(original)
    assert_equal original_values, original.values
  end

  def test_padded_grid_is_correct_height
    expected = @non_padded_grid.height + (2 * @pad_height)
    assert_equal expected, @padded.height
  end

  def test_padded_grid_is_correct_width
    expected = @non_padded_grid.width + (2 * @pad_width)
    assert_equal expected, @padded.width
  end

  def test_original_grid_is_unmodified_after_depadding
    original = RandomBinaryGrid.generate
    original_values = original.values.clone
    @padder.depad(original)
    assert_equal original_values, original.values
  end

  def test_padded_grid_still_valid
    assert @padded.valid?
  end

  def test_pad_depad_returns_starting_values
    assert_equal @non_padded_grid.values, @depadded.values
  end

  def test_depadded_grid_still_valid
    assert @depadded.valid?
  end

  def test_horizontal_padding_values
    padding_area = @padded.values.map do |row|
      row[0..@pad_width - 1]
    end

    assert_equal [@pad_value], padding_area.flatten.uniq
  end

  def test_vertical_padding_values
    top_padding_area = @padded.values[0..@pad_height - 1]
    bottom_padding_area = @padded.values[-@pad_height..-1]
    all_padding_rows = top_padding_area + bottom_padding_area

    assert_equal [@pad_value], all_padding_rows.flatten.uniq
  end
end
