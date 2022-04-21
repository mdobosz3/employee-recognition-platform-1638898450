# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :photo, content_type: ['image/png', 'image/jpeg']

  has_many :orders, dependent: :destroy
  has_many :employees, through: :orders

  has_many :category_rewards, dependent: :destroy
  has_many :categories, through: :category_rewards

  has_one_attached :photo
end
