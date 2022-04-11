# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CRUD category', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when admin performs CRUD Category' do
    let!(:admin_user) { create(:admin_user) }
    let!(:reward) { create(:reward) }
    let!(:category) { build(:category) }



    it 'CRUD category' do
      login_as(admin_user)
      visit admin_root_path
    
      click_link 'Categories'
      click_link 'New Category'
      fill_in 'Title', with: category.title
      click_button 'Create Category'
      expect(page).to have_content 'Category was successfully created.'
      expect(page).to have_content category.title


      click_link 'Rewards'
      click_link 'Edit'
      expect(page).to have_unchecked_field(category.title)
      check category.title
      click_button 'Update Reward'
      expect(page).to have_content 'Reward was successfully updated.'

      click_link 'Categories'
      click_link 'Delete'
      expect(page).to have_content 'The category cannot be deleted. It is assigned to the reward.'

      click_link 'Rewards'
      click_link 'Edit'
      expect(page).to have_checked_field(category.title)
      uncheck category.title
      click_button 'Update Reward'
      expect(page).to have_content 'Reward was successfully updated.'

      click_link 'Categories'
      click_link 'Edit'
      fill_in 'Title', with: 'title test edit'
      click_button 'Update Category'
      expect(page).to have_content 'Category was successfully updated.'
      expect(page).to have_content 'title test edit'

      click_link 'Delete'
      expect(page).to have_content 'Category was successfully destroyed.'
    end
  end
end
