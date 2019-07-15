# frozen_string_literal: true

# Class representing Stephen Wolfram's proposed cellular automata for generating
# skin patterns. Represents the neighbourhood of a given skill cell, and two
# chemicals present in its neighbourhood that act to encourage or inhibit
# the pigmentation of the cell.
class WolframRule
  attr_accessor :distance_1_value, :distance_2_value

  INNER_VALUE = 1
  DISTANCE_1_VALUE = -0.4
  DISTANCE_2_VALUE = -0.2

  class << self
    def generate(distance_1_value: nil,
                 distance_2_value: nil,
                 striped_direction: nil)

      # Set defaults like so since params may arrive as nil from controller params
      distance_1_value ||= DISTANCE_1_VALUE
      distance_2_value ||= DISTANCE_2_VALUE
      striped_direction ||= :none

      values = value_array(distance_1_value, distance_2_value, striped_direction)
      Grid.new values
    end

    private

    def value_array(distance_1_value, distance_2_value, striped_direction)
      iv = INNER_VALUE
      v1 = distance_1_value
      v2 = distance_2_value

      values = [
        [v2, v2, v2, v2, v2, v2, v2],
        [v2, v1, v1, v1, v1, v1, v2],
        [v2, v1, iv, iv, iv, v1, v2],
        [v2, v1, iv, iv, iv, v1, v2],
        [v2, v1, iv, iv, iv, v1, v2],
        [v2, v1, v1, v1, v1, v1, v2],
        [v2, v2, v2, v2, v2, v2, v2]
      ]

      striped_values(values, striped_direction)
    end

    def striped_values(unstriped_values, striped_direction)
      output = unstriped_values.dup

      case striped_direction.to_sym
      when :vertical
        output = vertically_striped(output)
      when :horizontal
        output = horizontally_striped(output)
      end

      output
    end

    # TODO: the two *_striped methods are actually inverted. The literature
    # seems to contradict the experimental results, so these have been swapped
    # for now until the issue can be investigated.

    def vertically_striped(unstriped)
      output = unstriped.dup
      row_width = output[0].length

      # Zero out top and bottom 2 rows
      output[0] = [0] * row_width
      output[1] = [0] * row_width
      output[-1] = [0] * row_width
      output[-2] = [0] * row_width
      output
    end

    def horizontally_striped(unstriped)
      unstriped.map do |row|
        updated_row = row

        # Zero out right- & left-most 2 values on each row
        updated_row[0] = 0
        updated_row[1] = 0
        updated_row[-1] = 0
        updated_row[-2] = 0
        updated_row
      end
    end
  end
end
