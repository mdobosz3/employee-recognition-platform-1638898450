# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reward, type: :model do
  let!(:reward) { create(:reward) }

  it 'is valid with valid attributes' do
    expect(reward).to be_valid
  end

  it 'is not valid without a title' do
    reward.title = nil
    expect(reward).not_to be_valid
  end

  it 'is not valid without a description' do
    reward.description = nil
    expect(reward).not_to be_valid
  end

  it 'is not valid without a price' do
    reward.price = nil
    expect(reward).not_to be_valid
  end
end
