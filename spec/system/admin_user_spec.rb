# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "tests if an admin can log in", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }

  it 'admin log in' do
    visit root_path
    click_link 'Admin Dashboard'
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end
end
