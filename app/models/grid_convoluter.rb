# frozen_string_literal: true

class GridConvoluter
  def initialize(convolution_matrix)
    @convolution_matrix = convolution_matrix
    check_size
  end

  def check_size
    dimensions = [@convolution_matrix.width, @convolution_matrix.height]
    has_any_even_dimensions = dimensions.any?(&:even?)
    raise ConvolutionMatrixSizeError if has_any_even_dimensions
  end

  def convolute(grid)
    padded = pad_grid(grid)

    # Get indices of the original, non-padded area
    x_indices = original_grid_x_indices(grid)
    y_indices = original_grid_y_indices(grid)

    summed = summed_neighbourhood_values(padded, x_indices, y_indices)

    Grid.new summed
  end

  private

  def summed_neighbourhood_values(padded_grid, original_grid_x_indices, original_grid_y_indices)
    summed = []
    original_grid_y_indices.each do |y|
      summed_row = []
      original_grid_x_indices.each do |x|
        summed_row << neighbourhood_sum(padded_grid, y_index: y, x_index: x)
      end
      summed << summed_row
    end
    summed
  end

  def original_grid_y_indices(unpadded)
    min_y = vertical_neighbourhood_radius
    max_y = min_y + unpadded.height - 1
    min_y..max_y
  end

  def original_grid_x_indices(unpadded)
    min_x = lateral_neighbourhood_radius
    max_x = min_x + unpadded.width - 1
    min_x..max_x
  end

  def neighbourhood_sum(grid, x_index:, y_index:)
    neighbourhood = neighbourhood(grid, x_index: x_index, y_index: y_index)

    multiplied =
      neighbourhood
      .zip(@convolution_matrix.values)
      .map do |row1, row2|
        row1.zip(row2).map { |v1, v2| v1 * v2 }
      end

    multiplied.flatten.sum
  end

  def neighbourhood(grid, x_index:, y_index:)
    x_start = x_index - lateral_neighbourhood_radius
    x_end = x_index + lateral_neighbourhood_radius

    y_start = y_index - vertical_neighbourhood_radius
    y_end = y_index + vertical_neighbourhood_radius

    neighbourhood_rows = grid.values[y_start..y_end]

    neighbourhood_rows.map do |row|
      row[x_start..x_end]
    end
  end

  def pad_grid(grid)
    padder = GridPadder.new(
      pad_value: 0,
      pad_width: lateral_neighbourhood_radius,
      pad_height: vertical_neighbourhood_radius
    )

    padder.pad(grid)
  end

  def lateral_neighbourhood_radius
    (@convolution_matrix.width - 1) / 2
  end

  def vertical_neighbourhood_radius
    (@convolution_matrix.height - 1) / 2
  end
end
