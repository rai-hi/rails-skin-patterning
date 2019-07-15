# frozen_string_literal: true

# Class representing a grid of values.
#
# Values is a nested array, representing the values of the grid. The outer array
# contains the rows, and each inner array is a single row of values.
# e.g.:
#   values = [
#             [1, 0, 1],
#             [0, 1, 0],
#             [1, 1, 1],
#             [0, 0, 0]
#           ]
class Grid
  # `include` & `attr_accessor` since the class isn't persisted to DB
  include ActiveModel::Model
  attr_reader :values

  validate :validate_not_empty, :validate_row_sizes, :validate_values

  def initialize(array)
    @values = array
  end

  def height
    @values.size
  end

  def width
    @values[0].size
  end

  def validate_not_empty
    if values.blank?
      errors.add(:values, :empty_grid)
      return
    end

    @values.each do |row|
      errors.add(:values, :empty_row) if row.blank?
    end
  end

  def validate_row_sizes
    return if values.blank?

    row_size = @values[0].size

    @values.each do |row|
      errors.add(:values, :invalid_size) if row.size != row_size
    end
  end

  def validate_values
    values.each do |row|
      row.each do |cell|
        errors.add(:values, :invalid_values) unless valid_value? cell
      end
    end
  end

  def valid_value?(cell_value)
    cell_value.is_a? Numeric
  end

  def ==(other)
    true if @values == other.values
  end
end
