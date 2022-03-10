# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { not_delivered: 0, delivered: 1 }
  serialize :reward_snapshot

  belongs_to :employee
  belongs_to :reward

  def snapshot_price
    reward_snapshot.price
  end
end
