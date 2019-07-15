# frozen_string_literal: true

require 'test_helper'

class SkinSimulationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show without any params successfully' do
    get skin_simulation_url
    assert_response :success
  end

  test 'should post AJAX successfully' do
    post skin_simulation_url, xhr: true
    assert_response :success
  end

  test 'get request returns array of frame values' do
    get skin_simulation_url
    frames = JSON.parse(@response.body)
    assert_equal [0, 1], frames.flatten.uniq.sort
  end

  test 'post sets array of frame values to frames instance var' do
    post skin_simulation_url, xhr: true
    assert_equal [0, 1], assigns(:frames).flatten.uniq.sort
  end

  test 'parameters get passed to simulator on post' do
    simulator_mock = MiniTest::Mock.new
    real_simulator = SkinSimulator.new(grid: sample_grid)

    expected_params = {
      grid: sample_grid,
      activator_strength: 1,
      inhibitor_strength: 2,
      striped_direction: 'vertical'
    }
    request_params = expected_params.except :grid

    simulator_mock.expect(:call, real_simulator, [expected_params])

    RandomBinaryGrid.stub(:generate, sample_grid) do
      SkinSimulator.stub(:new, simulator_mock) do
        post skin_simulation_url, xhr: true, params: request_params
      end
    end
    assert_mock simulator_mock
  end

  def test_random_grid_used_as_starting_point
    random_grid_mock = MiniTest::Mock.new
    random_grid_mock.expect :call, sample_grid

    RandomBinaryGrid.stub(:generate, random_grid_mock) do
      post skin_simulation_url, xhr: true
    end
    assert_mock random_grid_mock
  end

  def sample_grid
    Grid.new([[1]])
  end
end
