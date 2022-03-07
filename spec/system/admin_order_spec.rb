# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order check', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when the admin checks the order list of all employees' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }
    let(:admin_user) { create(:admin_user) }
    let(:company_value) { create(:company_value) }
    let!(:reward) { create(:reward) }
    

    before do
      create(:kudo, receiver: employee1)
      create(:kudo, receiver: employee2)
    end

    it 'order list' do
        sign_in admin_user

        visit admin_root_path
        click_link 'Orders'
        expect(page).not_to have_content employee1.email
        expect(page).not_to have_content employee2.email
        expect(page).not_to have_content reward.title
        expect(page).not_to have_content reward.description
        expect(page).not_to have_content reward.price
        
        create(:order, employee_id: employee1.id, reward: reward, reward_snapshot: reward) 
        create(:order, employee_id: employee2.id, reward: reward, reward_snapshot: reward) 

        visit admin_root_path
        click_link 'Orders'

        expect(page).to have_content employee1.email
        expect(page).to have_content employee2.email
        expect(page).to have_content reward.title
        expect(page).to have_content reward.description
        expect(page).to have_content reward.price.to_i
        
    end
  end
end
