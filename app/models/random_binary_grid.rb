# frozen_string_literal: true

# Generates a Grid of random 1 or 0 values
class RandomBinaryGrid
  DEFAULT_WIDTH = 100
  DEFAULT_HEIGHT = DEFAULT_WIDTH

  def self.generate(height = DEFAULT_HEIGHT, width = DEFAULT_HEIGHT)
    values = []
    row = nil
    height.times do
      row = []
      width.times do
        row << random_value
      end
      values << row
    end

    Grid.new(values)
  end

  def self.random_value
    [0, 1].sample
  end
end
