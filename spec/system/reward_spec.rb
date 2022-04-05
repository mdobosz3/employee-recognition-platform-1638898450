# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

  let!(:reward1) { create(:reward) }
  let!(:reward2) { create(:reward) }
  let!(:reward3) { create(:reward) }
  let!(:reward4) { create(:reward) }
  let!(:reward5) { create(:reward) }
  let!(:reward6) { create(:reward) }
  let!(:reward7) { create(:reward) }
  let!(:reward8) { create(:reward) }
  let!(:reward9) { create(:reward) }
  let!(:reward10) { create(:reward, price: 3) }

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
    expect(page).not_to have_content reward10.title
    expect(page).not_to have_content reward10.price
    within('[data-test-id="page_last"]') do
      click_link '2'
    end
    expect(page).to have_content reward10.title
    expect(page).to have_content reward10.price
  end
end
