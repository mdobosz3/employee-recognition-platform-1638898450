# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let(:admin_user) { create(:admin_user) }
  let(:company_value) { create(:company_value) }
  let!(:reward) { create(:reward, price: 1) }
  let(:reward2) { create(:reward, price: 10) }

  it 'Buying a reward' do
    create(:kudo, receiver: employee)
    sign_in employee
    visit root_path
    click_link 'Rewards'
    within('[data-test-id="Kudo_Points"]') do
      expect(page).to have_content '1'
    end

    click_link 'Buy'
    expect(page).to have_content 'Reward was successfully buying.'
    within('[data-test-id="Kudo_Points"]') do
      expect(page).to have_content '0'
    end

    click_link 'Orders'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    sign_in admin_user
    visit admin_root_path
    click_link 'Rewards'
    click_link 'Edit'
    fill_in 'reward[price]', with: reward2.price

    sign_in employee
    visit root_path
    click_link 'Orders'
    expect(page).to have_content reward.price
    expect(page).not_to have_content reward2.price
  end
end
