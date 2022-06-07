# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { not_delivered: 0, delivered: 1 }
  scope :filter_by_status, ->(status) { where status: status }

  serialize :reward_snapshot

  belongs_to :employee
  belongs_to :reward

  has_one :reward_code, dependent: :destroy
  has_one :address, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :address

  validates_associated :address

  def snapshot_price
    reward_snapshot.price
  end

  def post_address
    if address.nil?
      employee.email
    else
      "#{address.street}, #{address.postcode} #{address.city}"
    end
  end
end
