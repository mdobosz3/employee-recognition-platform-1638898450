# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

  it 'Reward index and show for employee' do
    sign_in employee
    visit root_path
    click_link 'Rewards'
    expect(page).to have_content reward.title
    expect(page).not_to have_content reward.description
    expect(page).to have_content reward.price

    click_link 'Show'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    click_link 'Back'
    expect(page).to have_content reward.title
    expect(page).not_to have_content reward.description
    expect(page).to have_content reward.price
  end
end
