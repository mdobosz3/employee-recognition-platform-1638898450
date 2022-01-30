# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CompanyValue check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let!(:company_value) { build(:company_value) }

  it 'crud CompanyValue' do
    login_as(admin_user)
    visit admin_root_path

    click_link 'Company value'
    click_link 'New Company value'
    fill_in 'Title', with: company_value.title
    click_button 'Create Company value'
    expect(page).to have_content 'Company value was successfully created.'
    expect(page).to have_content company_value.title

    click_link 'Edit'
    fill_in 'Title', with: 'title test edit'
    click_button 'Update Company value'
    expect(page).to have_content 'Company value was successfully updated.'
    expect(page).to have_content 'title test edit'

    click_link 'Delete'
    expect(page).to have_content 'Company value was successfully destroyed.'
    expect(page).not_to have_content 'title test edit'
  end
end
