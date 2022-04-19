# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward filtering by category', type: :system do
  context 'when an employee filters reward' do
    let!(:employee) { create(:employee) }
    let!(:category_reward1) { create(:category_reward) }
    let!(:category_reward2) { create(:category_reward) }

    it 'when employee filters by category' do
      sign_in employee

      visit root_path
      click_link 'Rewards'
      expect(page).to have_content category_reward1.reward.title
      expect(page).to have_content category_reward2.reward.title

      select category_reward1.category.title, from: 'category_id'
      click_button 'Filter'
      expect(page).to have_content category_reward1.reward.title
      expect(page).not_to have_content category_reward2.reward.title

      select category_reward2.category.title, from: 'category_id'
      click_button 'Filter'
      expect(page).not_to have_content category_reward1.reward.title
      expect(page).to have_content category_reward2.reward.title

      select 'All Category', from: 'category_id'
      click_button 'Filter'
      expect(page).to have_content category_reward1.reward.title
      expect(page).to have_content category_reward2.reward.title
    end
  end
end
