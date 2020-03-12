require "application_system_test_case"

class LayrecsTest < ApplicationSystemTestCase
  setup do
    @layrec = layrecs(:one)
  end

  test "visiting the index" do
    visit layrecs_url
    assert_selector "h1", text: "Layrecs"
  end

  test "creating a Layrec" do
    visit layrecs_url
    click_on "New Layrec"

    fill_in "Address", with: @layrec.address
    fill_in "Address2", with: @layrec.address2
    fill_in "City", with: @layrec.city
    fill_in "Cost", with: @layrec.cost
    fill_in "Delivery", with: @layrec.delivery
    fill_in "Discount", with: @layrec.discount
    fill_in "Email", with: @layrec.email
    fill_in "Fee", with: @layrec.fee
    fill_in "Margin", with: @layrec.margin
    fill_in "Name", with: @layrec.name
    fill_in "Phone", with: @layrec.phone
    fill_in "Profit", with: @layrec.profit
    fill_in "Sale rep", with: @layrec.sale_rep
    fill_in "State", with: @layrec.state
    fill_in "Sub total", with: @layrec.sub_total
    fill_in "Tax", with: @layrec.tax
    check "Tax inc" if @layrec.tax_inc
    fill_in "Total", with: @layrec.total
    fill_in "User", with: @layrec.user_id
    fill_in "Zip", with: @layrec.zip
    click_on "Create Layrec"

    assert_text "Layrec was successfully created"
    click_on "Back"
  end

  test "updating a Layrec" do
    visit layrecs_url
    click_on "Edit", match: :first

    fill_in "Address", with: @layrec.address
    fill_in "Address2", with: @layrec.address2
    fill_in "City", with: @layrec.city
    fill_in "Cost", with: @layrec.cost
    fill_in "Delivery", with: @layrec.delivery
    fill_in "Discount", with: @layrec.discount
    fill_in "Email", with: @layrec.email
    fill_in "Fee", with: @layrec.fee
    fill_in "Margin", with: @layrec.margin
    fill_in "Name", with: @layrec.name
    fill_in "Phone", with: @layrec.phone
    fill_in "Profit", with: @layrec.profit
    fill_in "Sale rep", with: @layrec.sale_rep
    fill_in "State", with: @layrec.state
    fill_in "Sub total", with: @layrec.sub_total
    fill_in "Tax", with: @layrec.tax
    check "Tax inc" if @layrec.tax_inc
    fill_in "Total", with: @layrec.total
    fill_in "User", with: @layrec.user_id
    fill_in "Zip", with: @layrec.zip
    click_on "Update Layrec"

    assert_text "Layrec was successfully updated"
    click_on "Back"
  end

  test "destroying a Layrec" do
    visit layrecs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Layrec was successfully destroyed"
  end
end
