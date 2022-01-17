# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee account', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { build(:employee) }

  it 'sign up and sign in' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    fill_in 'Password confirmation', with: employee.password
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
    click_link 'Log Out'

  #let!(:employee) { FactoryBot.attributes_for(:employee) }

    #it 'sign up and sign in' do
      #visit root_path
      #click_link 'Sign Up'
      #fill_in 'Email', with: employee
      #fill_in 'Password', with: employee
      #fill_in 'Password confirmation', with: employee
      #click_button 'Sign up'
      #expect(page).to have_text('Welcome! You have signed up successfully.')
      #click_link 'Log Out'

    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
