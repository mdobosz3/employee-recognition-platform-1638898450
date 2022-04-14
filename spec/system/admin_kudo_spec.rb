# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee, number_of_available_kudos: 199) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 533) }
  let!(:admin_user) { create(:admin_user) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }
  let!(:kudo) { build(:kudo) }

  it 'crud kudo' do
    login_as(admin_user)
    visit admin_root_path

    click_link 'Kudos'
    click_link 'New Kudo'
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee1.email, from: 'kudo[giver_id]'
    select employee2.email, from: 'kudo[receiver_id]'
    select company_value1.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'title'

    click_link 'Edit'
    fill_in 'Title', with: 'title test edit'
    fill_in 'Content', with: 'content test edit'
    select employee2.email, from: 'kudo[giver_id]'
    select employee1.email, from: 'kudo[receiver_id]'
    select company_value2.title, from: 'kudo[company_value_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated.'
    expect(page).to have_content 'title test edit'
    click_link 'Back'

    click_link 'Delete'
    expect(page).to have_content 'Kudo was successfully destroyed.'
    expect(page).to have_content 'Kudos'
    expect(page).not_to have_content 'title test edit'
  end

  it 'add available kudos to employees' do
    login_as(admin_user)
    visit admin_root_path
    click_link 'Employees'

    expect(page).to have_content employee1.number_of_available_kudos
    expect(page).to have_content employee2.number_of_available_kudos
    click_link 'Add Kudos'
    click_button 'Add'
    expect(page).to have_content '209'
    expect(page).to have_content '543'
  end
end
