require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'root url maps to the home controller' do
    get '/'
    assert_equal 'HomeController', @controller.class.name
  end
end
