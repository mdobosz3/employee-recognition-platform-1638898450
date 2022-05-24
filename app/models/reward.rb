# frozen_string_literal: true

class Reward < ApplicationRecord
  enum delivery_method: { online: 0, post: 1 }

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :photo, content_type: ['image/png', 'image/jpeg']

  has_many :orders, dependent: :destroy
  has_many :employees, through: :orders

  has_many :category_rewards, dependent: :destroy
  has_many :categories, through: :category_rewards

  has_one_attached :photo

  def self.import(file)
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        slug = row[4]
        reward = Reward.find_by!(slug: slug)
        binding.pry
        Reward.update(reward.id, row.to_h)
      end
    end
  rescue ActiveRecord::RecordNotFound, CSV::MalformedCSVError
    false
  end
end
