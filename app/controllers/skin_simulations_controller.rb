# frozen_string_literal: true

class SkinSimulationsController < ApplicationController
  def show
    render json: simulation_frames
  end

  def create
    @frames = simulation_frames
  end

  private

  def simulation_frames
    simulator = SkinSimulator.new(
      grid: initial_grid,
      inhibitor_strength: simulation_params[:inhibitor_strength].to_f,
      activator_strength: simulation_params[:activator_strength].to_f,
      striped_direction: simulation_params[:striped_direction]
    )

    simulator.frames.map(&:values)
  end

  def initial_grid
    RandomBinaryGrid.generate
  end

  def simulation_params
    params.permit(:activator_strength, :inhibitor_strength, :striped_direction)
  end
end
