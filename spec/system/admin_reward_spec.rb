# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let!(:reward) { build(:reward) }

  it 'crud Reward' do
    login_as(admin_user)
    visit admin_root_path

    click_link 'Rewards'
    click_link 'New Reward'
    fill_in 'Title', with: reward.title
    fill_in 'Description', with: reward.description
    fill_in 'Price', with: reward.price
    click_button 'Create Reward'
    expect(page).to have_content 'Reward was successfully created.'
    expect(page).to have_content reward.title

    click_link 'Edit'
    fill_in 'Title', with: 'title test edit'
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    expect(page).to have_content 'title test edit'

    click_link 'Delete'
    expect(page).to have_content 'Reward was successfully destroyed.'
    expect(page).not_to have_content 'title test edit'
  end
end
