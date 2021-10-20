require "test_helper"

class CepControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cep_index_url
    assert_response :success
  end

  test "should get show" do
    get cep_show_url
    assert_response :success
  end
end
