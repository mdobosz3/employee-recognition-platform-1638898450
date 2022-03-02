# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:company_value) { create(:company_value) }
  let!(:kudo) { create(:kudo, giver: employee, receiver: employee, company_value: company_value) }
  let!(:reward) { create(:reward) }

  it 'Buying a reward' do
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
  end
end
