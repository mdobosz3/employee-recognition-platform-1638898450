# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order filtering', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when an employee filters orders' do
    let!(:employee) { create(:employee) }
    let!(:delivered_order) { create(:order, status: 'delivered') }
    let!(:not_delivered_order) { create(:order, status: 'not_delivered') }

    it 'filters by the delivery status' do
      sign_in employee

      visit root_path
      click_link 'Orders'
      expect(page).to have_content delivered_order.reward.description
      expect(page).to have_content not_delivered_order.reward.description

      click_link 'Delivered'
      expect(page).to have_content delivered_order.reward.description
      expect(page).not_to have_content not_delivered_order.reward.description

      click_link 'Not delivered'
      expect(page).not_to have_content delivered_order.reward.title
      expect(page).to have_content not_delivered_order.reward.title

      click_link 'All'
      expect(page).to have_content delivered_order.reward.title
      expect(page).to have_content not_delivered_order.reward.title
    end
  end
end
