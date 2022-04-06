# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward check', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when the employee checks the rewards' do
    let(:employee) { create(:employee) }
    let!(:reward) { create(:reward) }

    before do
      sign_in employee
      visit root_path
      click_link 'Rewards'
    end

    it 'Reward index and show for employee' do
      expect(page).to have_content reward.title
      expect(page).not_to have_content reward.description
      expect(page).to have_content reward.price

      click_link 'Show', match: :first
      expect(page).to have_content reward.title
      expect(page).to have_content reward.description
      expect(page).to have_content reward.price

      click_link 'Back'
      expect(page).to have_content reward.title
      expect(page).not_to have_content reward.description
      expect(page).to have_content reward.price
    end

    it 'Pagination check' do
      create_list(:reward, 18)
      visit current_path

      expect(page).not_to have_content Reward.last.title 
      expect(page).not_to have_content Reward.last.price
      within('[data-test-id="page_last"]') do
        click_link '2'
      end
      expect(page).to have_content Reward.last.title
      expect(page).to have_content Reward.last.price
    end
  end
end
