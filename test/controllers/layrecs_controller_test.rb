require 'test_helper'

class LayrecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @layrec = layrecs(:one)
  end

  test "should get index" do
    get layrecs_url
    assert_response :success
  end

  test "should get new" do
    get new_layrec_url
    assert_response :success
  end

  test "should create layrec" do
    assert_difference('Layrec.count') do
      post layrecs_url, params: { layrec: { address: @layrec.address, address2: @layrec.address2, city: @layrec.city, cost: @layrec.cost, delivery: @layrec.delivery, discount: @layrec.discount, email: @layrec.email, fee: @layrec.fee, margin: @layrec.margin, name: @layrec.name, phone: @layrec.phone, profit: @layrec.profit, sale_rep: @layrec.sale_rep, state: @layrec.state, sub_total: @layrec.sub_total, tax: @layrec.tax, tax_inc: @layrec.tax_inc, total: @layrec.total, user_id: @layrec.user_id, zip: @layrec.zip } }
    end

    assert_redirected_to layrec_url(Layrec.last)
  end

  test "should show layrec" do
    get layrec_url(@layrec)
    assert_response :success
  end

  test "should get edit" do
    get edit_layrec_url(@layrec)
    assert_response :success
  end

  test "should update layrec" do
    patch layrec_url(@layrec), params: { layrec: { address: @layrec.address, address2: @layrec.address2, city: @layrec.city, cost: @layrec.cost, delivery: @layrec.delivery, discount: @layrec.discount, email: @layrec.email, fee: @layrec.fee, margin: @layrec.margin, name: @layrec.name, phone: @layrec.phone, profit: @layrec.profit, sale_rep: @layrec.sale_rep, state: @layrec.state, sub_total: @layrec.sub_total, tax: @layrec.tax, tax_inc: @layrec.tax_inc, total: @layrec.total, user_id: @layrec.user_id, zip: @layrec.zip } }
    assert_redirected_to layrec_url(@layrec)
  end

  test "should destroy layrec" do
    assert_difference('Layrec.count', -1) do
      delete layrec_url(@layrec)
    end

    assert_redirected_to layrecs_url
  end
end
