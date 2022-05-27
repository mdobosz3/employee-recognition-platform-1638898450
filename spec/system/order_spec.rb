# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order check', type: :system do

  context 'when an employee purchase a reward and check order list' do
    let!(:employee) { create(:employee) }
    let(:admin_user) { create(:admin_user) }
    let(:company_value) { create(:company_value) }
    let!(:reward) { create(:reward, price: 2) }
    let!(:address) { build(:address) }

    before do
      create(:kudo, receiver: employee)
      create(:kudo, receiver: employee)
      create(:kudo, receiver: employee)
    end

    it 'Buying a reward onlone and by post' do
      Capybara.using_session(:employee) do
        sign_in employee

        visit root_path
        click_link 'Rewards'
        within('[data-test-id="Kudo_Points"]') do
          expect(page).to have_content '3'
        end

        click_link 'Buy'
        click_link 'Delivery online'
        expect(page).to have_content 'Reward was successfully buying.'
        within('[data-test-id="Kudo_Points"]') do
          expect(page).to have_content '1'
        end

        click_link 'Orders'
        expect(page).to have_content reward.title
        expect(page).to have_content reward.description
        expect(page).to have_content reward.price.to_i
      end

      Capybara.using_session(:admin_user) do
        sign_in admin_user

        visit admin_root_path
        click_link 'Rewards'
        click_link 'Edit'
        fill_in 'reward[price]', with: '1'
        select 'post', from: 'reward[delivery_method]'
        click_button 'Update Reward'
        expect(page).to have_content 'Reward was successfully updated.'
      end

      Capybara.using_session(:employee) do
        sign_in employee

        visit root_path
        click_link 'Orders'
        within('[data-test-id="Order_Price"]') do
          expect(page).to have_content '2'
        end

        click_link 'Rewards'
        expect(page).to have_content 'post'
        click_link 'Buy'
        fill_in 'Street', with: address.street
        fill_in 'Postcode', with: address.postcode
        fill_in 'City', with: address.city
        click_button 'Delivery by post'
        expect(page).to have_content 'Reward was successfully buying.'
        within('[data-test-id="Kudo_Points"]') do
          expect(page).to have_content '0'
        end
      end
    end
  end
end
