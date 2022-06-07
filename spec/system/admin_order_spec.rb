# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order check', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when the admin checks the order list of all employees and delivery of the order' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }
    let(:admin_user) { create(:admin_user) }
    let(:company_value) { create(:company_value) }
    let!(:reward) { create(:reward, delivery_method: 'post') }

    before do
      create(:kudo, receiver: employee1)
      create(:kudo, receiver: employee2)
    end

    it 'order list and delivery button' do
      sign_in admin_user

      visit admin_root_path
      click_link 'Orders'
      expect(page).not_to have_content employee1.first_name
      expect(page).not_to have_content employee2.first_name
      expect(page).not_to have_content reward.title
      expect(page).not_to have_content reward.description
      expect(page).not_to have_content reward.price

      order1 = create(:order, employee_id: employee1.id, reward: reward, reward_snapshot: reward)
      order2 = create(:order, employee_id: employee2.id, reward: reward, reward_snapshot: reward)
      address1 = create(:address, order: order1)
      address2 = create(:address, order: order2)
      order1.address = address1
      order2.address = address2

      visit admin_root_path
      click_link 'Orders'

      expect(page).to have_content employee1.first_name
      expect(page).to have_content employee2.first_name
      expect(page).to have_content reward.title
      expect(page).to have_content reward.description
      expect(page).to have_content reward.price.to_i

      expect(page).to have_button 'Deliver'
      click_button 'Deliver', match: :first
      expect(page).to have_content 'Order was successfully delivered.'
      click_button 'Deliver'
      expect(page).to have_content 'Order was successfully delivered.'
      expect(page).to have_no_button 'Deliver'
    end
  end
end
