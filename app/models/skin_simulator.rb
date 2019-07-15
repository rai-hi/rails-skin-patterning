# frozen_string_literal: true

class SkinSimulator
  attr_reader :state

  def initialize(grid:,
                 inhibitor_strength: nil,
                 activator_strength: nil,
                 striped_direction: nil)
    @previous_state_values = []
    @stable = false
    @state = grid

    # TODO: Test params get passed through
    @rule = WolframRule.generate(
      distance_1_value: activator_strength,
      distance_2_value: inhibitor_strength,
      striped_direction: striped_direction
    )
  end

  def frames
    step until stable?
    simulated_grids = @previous_state_values.map { |values| Grid.new values }
    simulated_grids
  end

  def step
    convoluter = GridConvoluter.new @rule
    convoluted = convoluter.convolute @state
    new_values = convoluted.values.map do |row|
      row.map do |val|
        val.positive? ? 1 : 0
      end
    end
    @previous_state_values << @state.values
    @state = Grid.new new_values
  end

  def stable?
    return true if @stable

    duplicate_frames = @previous_state_values.last(5).uniq.size != @previous_state_values.size

    @stable = true if duplicate_frames
  end
end
