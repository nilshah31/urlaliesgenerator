require 'test_helper'

class UrlGeneratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url_generator = url_generators(:one)
  end

  test "should get index" do
    get url_generators_url
    assert_response :success
  end

  test "should get new" do
    get new_url_generator_url
    assert_response :success
  end

  test "should create url_generator" do
    assert_difference('UrlGenerator.count') do
      post url_generators_url, params: { url_generator: { key: @url_generator.key, url: @url_generator.url } }
    end

    assert_redirected_to url_generator_url(UrlGenerator.last)
  end

  test "should show url_generator" do
    get url_generator_url(@url_generator)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_generator_url(@url_generator)
    assert_response :success
  end

  test "should update url_generator" do
    patch url_generator_url(@url_generator), params: { url_generator: { key: @url_generator.key, url: @url_generator.url } }
    assert_redirected_to url_generator_url(@url_generator)
  end

  test "should destroy url_generator" do
    assert_difference('UrlGenerator.count', -1) do
      delete url_generator_url(@url_generator)
    end

    assert_redirected_to url_generators_url
  end
end
