# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee check', type: :system do

  let!(:employee1) { create(:employee) }
  let!(:employee2) { build(:employee) }
  let!(:admin_user) { create(:admin_user) }

  it 'RUD employee' do
    login_as(admin_user)
    visit admin_root_path

    click_link 'Employees'
    expect(page).to have_content employee1.first_name
    expect(page).to have_content employee1.last_name
    expect(page).to have_content employee1.number_of_available_kudos
    expect(page).to have_content employee1.email

    click_link 'Edit'
    fill_in 'First name', with: employee2.first_name
    fill_in 'Last name', with: employee2.last_name
    fill_in 'Number of available kudos', with: '20'
    fill_in 'Email', with: employee2.email
    click_button 'Update Employee'
    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).to have_content employee2.first_name
    expect(page).to have_content employee2.last_name
    expect(page).to have_content '20'
    expect(page).to have_content employee2.email

    click_link 'Delete'
    expect(page).to have_content 'Employee was successfully destroyed.'

    expect(page).not_to have_content employee1.first_name
    expect(page).not_to have_content employee2.first_name
  end

end
