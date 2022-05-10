# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee account', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee_attributes) { attributes_for(:employee) }

  it 'sign up and sign in' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First name', with: employee_attributes[:first_name]
    fill_in 'Last name', with: employee_attributes[:last_name]
    fill_in 'Email', with: employee_attributes[:email]
    fill_in 'Password', with: employee_attributes[:password]
    fill_in 'Password confirmation', with: employee_attributes[:password]
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
    click_link 'Log Out'

    click_link 'Log In'
    fill_in 'Email', with: employee_attributes[:email]
    fill_in 'Password', with: employee_attributes[:password]
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
