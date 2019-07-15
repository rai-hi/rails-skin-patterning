# frozen_string_literal: true

# Class to handle the adding and removing of padding of Grids
# TODO: would be better to use the actual grid.width/height throughout instead of nested_array.size
class GridPadder
  def initialize(pad_value:, pad_width:, pad_height:)
    @pad_value = pad_value
    @pad_width = pad_width
    @pad_height = pad_height
  end

  def pad(grid)
    grid_values = grid.clone.values

    padded_horizontally = pad_horizontally grid_values
    padded_both_directions = pad_vertically padded_horizontally

    Grid.new padded_both_directions
  end

  def depad(grid)
    values = grid.clone.values

    depadded_horizontally = depad_horizontally(values)
    depadded_both_directions = depad_vertically(depadded_horizontally)

    Grid.new depadded_both_directions
  end

  private

  def pad_horizontally(nested_array)
    horizontal_padding = [@pad_value] * @pad_width

    nested_array.map do |row|
      horizontal_padding + row + horizontal_padding
    end
  end

  def pad_vertically(nested_array)
    padding_row = [@pad_value] * nested_array[0].size
    padding_rows = [padding_row] * @pad_height
    padding_rows + nested_array + padding_rows
  end

  def depad_horizontally(nested_array)
    horizontal_start_index = @pad_width
    horizontal_end_index = nested_array[0].size - @pad_width - 1

    nested_array.map do |row|
      row[horizontal_start_index..horizontal_end_index]
    end
  end

  def depad_vertically(nested_array)
    vertical_start_index = @pad_height
    vertical_end_index = nested_array.size - @pad_height - 1

    nested_array[vertical_start_index..vertical_end_index]
  end
end
