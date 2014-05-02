require 'test_helper'

class PaymentProfilesControllerTest < ActionController::TestCase
  setup do
    @payment_profile = payment_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_profile" do
    assert_difference('PaymentProfile.count') do
      post :create, payment_profile: { account_number: @payment_profile.account_number, account_type: @payment_profile.account_type, bank_name: @payment_profile.bank_name, rut: @payment_profile.rut }
    end

    assert_redirected_to payment_profile_path(assigns(:payment_profile))
  end

  test "should show payment_profile" do
    get :show, id: @payment_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_profile
    assert_response :success
  end

  test "should update payment_profile" do
    patch :update, id: @payment_profile, payment_profile: { account_number: @payment_profile.account_number, account_type: @payment_profile.account_type, bank_name: @payment_profile.bank_name, rut: @payment_profile.rut }
    assert_redirected_to payment_profile_path(assigns(:payment_profile))
  end

  test "should destroy payment_profile" do
    assert_difference('PaymentProfile.count', -1) do
      delete :destroy, id: @payment_profile
    end

    assert_redirected_to payment_profiles_path
  end
end
