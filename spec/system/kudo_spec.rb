require 'rails_helper'

RSpec.describe 'Kudo check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }

  it 'crud kudo' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    click_link 'New Kudos'
    fill_in "Title", with: 'title test'
    fill_in "Content", with: 'content test'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudos was successfully created.'

    click_link 'Edit'
    fill_in "Title", with: 'title test edit'
    fill_in "Content", with: 'content test edit'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudos was successfully updated.'

    click_link 'Delete'
    expect(page).to have_content 'Kudos was successfully destroyed.'

  end
end
