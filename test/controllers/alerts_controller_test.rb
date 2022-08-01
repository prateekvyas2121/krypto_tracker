# frozen_string_literal: true

require 'test_helper'

class AlertsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get alerts_index_url
    assert_response :success
  end

  test 'should get create' do
    get alerts_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get alerts_destroy_url
    assert_response :success
  end
end
