require "application_system_test_case"

class ExrecsTest < ApplicationSystemTestCase
  setup do
    @exrec = exrecs(:one)
  end

  test "visiting the index" do
    visit exrecs_url
    assert_selector "h1", text: "Exrecs"
  end

  test "creating a Exrec" do
    visit exrecs_url
    click_on "New Exrec"

    fill_in "Email", with: @exrec.email
    fill_in "Name", with: @exrec.name
    fill_in "Phone", with: @exrec.phone
    check "Tax inc" if @exrec.tax_inc
    fill_in "User", with: @exrec.user_id
    click_on "Create Exrec"

    assert_text "Exrec was successfully created"
    click_on "Back"
  end

  test "updating a Exrec" do
    visit exrecs_url
    click_on "Edit", match: :first

    fill_in "Email", with: @exrec.email
    fill_in "Name", with: @exrec.name
    fill_in "Phone", with: @exrec.phone
    check "Tax inc" if @exrec.tax_inc
    fill_in "User", with: @exrec.user_id
    click_on "Update Exrec"

    assert_text "Exrec was successfully updated"
    click_on "Back"
  end

  test "destroying a Exrec" do
    visit exrecs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exrec was successfully destroyed"
  end
end
