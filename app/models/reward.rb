# frozen_string_literal: true

class Reward < ApplicationRecord
  enum delivery_method: { online: 0, post: 1 }

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :photo, content_type: ['image/png', 'image/jpeg']

  has_many :orders, dependent: :destroy
  has_many :employees, through: :orders
  has_many :reward_codes, dependent: :destroy

  has_many :category_rewards, dependent: :destroy
  has_many :categories, through: :category_rewards

  has_one_attached :photo

  def self.import(file)
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        reward_hash = row.to_h
        number_of_codes = reward_hash.length - 5
        reward = Reward.find_by!(slug: reward_hash['slug'])
        Reward.update(reward.id, title: reward_hash['title'],
                                 description: reward_hash['description'],
                                 price: reward_hash['price'],
                                 delivery_method: reward_hash['delivery_method'])
        if number_of_codes > 9
          (1..number_of_codes).each do |i|
            reward.reward_codes.build(code: reward_hash["code#{i}"]) if RewardCode.find_by(code: reward_hash["code#{i}"]).nil?
          end
        end
        reward.save!
      end
    end
  end
end
