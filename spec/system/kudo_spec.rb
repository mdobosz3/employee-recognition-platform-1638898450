# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee, number_of_available_kudos: 1) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }
  let!(:kudo) { build(:kudo, giver: employee) }

  it 'crud kudo' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Available kudos: 1'
    within('[data-test-id="Kudo_Points"]') do
      expect(page).to have_content '0'
    end

    click_link 'New Kudo'
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select company_value1.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudos was successfully created.'
    expect(page).to have_content kudo.title
    expect(page).to have_content company_value1.title
    expect(page).to have_content 'Available kudos: 0'
    within('[data-test-id="Kudo_Points"]') do
      expect(page).to have_content '1'
    end

    # checking the creation of a new kudo with no minimum points
    click_link 'New Kudo'
    expect(page).to have_content 'You have no kudos available to give.'

    click_link 'Edit'
    fill_in 'Title', with: 'title test edit'
    fill_in 'Content', with: 'content test edit'
    select company_value2.title, from: 'kudo[company_value_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudos was successfully updated.'
    expect(page).to have_content 'title test edit'
    expect(page).to have_content company_value2.title

    # checking for kudo editing after 5 minutes
    travel 6.minutes do
      visit current_path
      expect(page).not_to have_link 'Edit'
      expect(page).not_to have_link 'Delete'
    end

    visit current_path
    click_link 'Delete'
    expect(page).to have_content 'Kudos was successfully destroyed.'
    expect(page).not_to have_content 'title test edit'
    within('[data-test-id="Kudo_Points"]') do
      expect(page).to have_content '0'
    end
  end
end
