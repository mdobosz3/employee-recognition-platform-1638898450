# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  has_many :orders
  has_many :employees, through: :orders
end
