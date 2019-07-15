# frozen_string_literal: true

require 'test_helper'

class WolframRuleTest < MiniTest::Test
  def setup
    @default_rule = WolframRule.generate
  end

  def test_rule_is_correct_height
    assert_equal 7, @default_rule.height
  end

  def test_rule_is_correct_width
    assert_equal 7, @default_rule.height
  end

  def test_rule_uses_expected_values
    assert_equal [-0.2, -0.4, 1], @default_rule.values.flatten.uniq
  end

  def test_rule_is_generated_correctly
    iv = 1
    v1 = -0.3
    v2 = 0.4

    rule = WolframRule.generate(distance_1_value: v1, distance_2_value: v2)

    expected = [
      [v2, v2, v2, v2, v2, v2, v2],
      [v2, v1, v1, v1, v1, v1, v2],
      [v2, v1, iv, iv, iv, v1, v2],
      [v2, v1, iv, iv, iv, v1, v2],
      [v2, v1, iv, iv, iv, v1, v2],
      [v2, v1, v1, v1, v1, v1, v2],
      [v2, v2, v2, v2, v2, v2, v2]
    ]
    assert_equal expected, rule.values
  end

  def test_vertically_striped_rule_has_zeroes_in_the_correct_cols
    vert_striped = WolframRule.generate(
      distance_1_value: 1, distance_2_value: 2, striped_direction: :vertical
    )

    expected = [
      [0, 0, 2, 2, 2, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 2, 2, 2, 0, 0]
    ]

    assert_equal expected, vert_striped.values
  end

  def test_horizontally_striped_rule_has_zeroes_in_the_correct_rows
    hori_striped = WolframRule.generate(
      distance_1_value: 1, distance_2_value: 2, striped_direction: :horizontal
    )

    expected = [
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [2, 1, 1, 1, 1, 1, 2],
      [2, 1, 1, 1, 1, 1, 2],
      [2, 1, 1, 1, 1, 1, 2],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0]
    ]

    assert_equal expected, hori_striped.values
  end
end
