# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee) }
  let!(:employee2) { create(:employee) }
  let!(:admin_user) { create(:admin_user) }
  let!(:kudo) { build(:kudo) }

  it 'crud kudo' do
    login_as(admin_user)
    visit admin_root_path

    click_link 'Kudos index'
    click_link 'New Kudo'
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee1.email, from: 'kudo[giver_id]'
    select employee2.email, from: 'kudo[receiver_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'title kudo'

    click_link 'Edit'
    fill_in 'Title', with: 'title test edit'
    fill_in 'Content', with: 'content test edit'
    select employee2.email, from: 'kudo[giver_id]'
    select employee1.email, from: 'kudo[receiver_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated.'
    expect(page).to have_content 'title test edit'
    click_link 'Back'

    click_link 'Delete'
    expect(page).to have_content 'Kudo was successfully destroyed.'
    expect(page).to have_content 'All Kudos'
  end
end