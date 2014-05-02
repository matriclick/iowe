require 'test_helper'

class AccountConfigurationsControllerTest < ActionController::TestCase
  setup do
    @account_configuration = account_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_configuration" do
    assert_difference('AccountConfiguration.count') do
      post :create, account_configuration: { allow_netting: @account_configuration.allow_netting, collection_mail_frecuency_in_days: @account_configuration.collection_mail_frecuency_in_days, user_id: @account_configuration.user_id }
    end

    assert_redirected_to account_configuration_path(assigns(:account_configuration))
  end

  test "should show account_configuration" do
    get :show, id: @account_configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_configuration
    assert_response :success
  end

  test "should update account_configuration" do
    patch :update, id: @account_configuration, account_configuration: { allow_netting: @account_configuration.allow_netting, collection_mail_frecuency_in_days: @account_configuration.collection_mail_frecuency_in_days, user_id: @account_configuration.user_id }
    assert_redirected_to account_configuration_path(assigns(:account_configuration))
  end

  test "should destroy account_configuration" do
    assert_difference('AccountConfiguration.count', -1) do
      delete :destroy, id: @account_configuration
    end

    assert_redirected_to account_configurations_path
  end
end
