# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }
  let!(:kudo) { build(:kudo) }

  it 'crud kudo' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    within('#Kudo_Points') do
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
    within('#Kudo_Points') do
      expect(page).to have_content '1'
    end

    click_link 'Edit'
    fill_in 'Title', with: 'title test edit'
    fill_in 'Content', with: 'content test edit'
    select company_value2.title, from: 'kudo[company_value_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudos was successfully updated.'
    expect(page).to have_content 'title test edit'
    expect(page).to have_content company_value2.title

    click_link 'Delete'
    expect(page).to have_content 'Kudos was successfully destroyed.'
    expect(page).not_to have_content 'title test edit'
    within('#Kudo_Points') do
      expect(page).to have_content '0'
    end
  end
end
