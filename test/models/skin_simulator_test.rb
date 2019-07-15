# frozen_string_literal: true

require 'test_helper'

class SkinSkimulatorTest < MiniTest::Test
  def setup
    size = 40
    @random_grid = RandomBinaryGrid.generate(size, size)
    @simulator = SkinSimulator.new grid: @random_grid
  end

  def test_step_causes_a_random_grid_to_change
    simulator = SkinSimulator.new grid: @random_grid
    simulator.step
    refute @random_grid.values == simulator.state.values
  end

  def test_frames_returns_an_array_of_grids
    assert_instance_of Array, @simulator.frames
  end

  def test_frames_are_all_different
    assert @simulator.frames.map(&:values).uniq.size > 1
  end

  def test_simulation_stabilises_eventually
    100.times do
      @simulator.step

      break if @simulator.stable?
    end

    assert @simulator.stable?
  end

  private

  def print_state(state)
    puts
    GridPrinter.print(state)
    puts
    puts
  end
end
