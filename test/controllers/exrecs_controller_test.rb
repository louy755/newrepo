require 'test_helper'

class ExrecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exrec = exrecs(:one)
  end

  test "should get index" do
    get exrecs_url
    assert_response :success
  end

  test "should get new" do
    get new_exrec_url
    assert_response :success
  end

  test "should create exrec" do
    assert_difference('Exrec.count') do
      post exrecs_url, params: { exrec: { email: @exrec.email, name: @exrec.name, phone: @exrec.phone, tax_inc: @exrec.tax_inc, user_id: @exrec.user_id } }
    end

    assert_redirected_to exrec_url(Exrec.last)
  end

  test "should show exrec" do
    get exrec_url(@exrec)
    assert_response :success
  end

  test "should get edit" do
    get edit_exrec_url(@exrec)
    assert_response :success
  end

  test "should update exrec" do
    patch exrec_url(@exrec), params: { exrec: { email: @exrec.email, name: @exrec.name, phone: @exrec.phone, tax_inc: @exrec.tax_inc, user_id: @exrec.user_id } }
    assert_redirected_to exrec_url(@exrec)
  end

  test "should destroy exrec" do
    assert_difference('Exrec.count', -1) do
      delete exrec_url(@exrec)
    end

    assert_redirected_to exrecs_url
  end
end
