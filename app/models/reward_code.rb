# frozen_string_literal: true

class RewardCode < ApplicationRecord
  enum status: { unused: 0, used: 1 }

  validates :code, :status, presence: true

  belongs_to :reward
  belongs_to :order, optional: true
end
