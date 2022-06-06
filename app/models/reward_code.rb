class RewardCode < ApplicationRecord
  enum sale: { unused: 0, used: 1 }

  validates :code, :sale, presence: true
  
  belongs_to :reward
  belongs_to :order, optional: true
end
