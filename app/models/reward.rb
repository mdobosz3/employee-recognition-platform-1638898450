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

  def self.import(file)
    begin
      ActiveRecord::Base.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row[3] == nil
            Reward.create_with(description: row[1], price: row[2]).find_or_create_by!(title: row[0])
          else
            title = row[3].split("-")
            title[1] = -1 unless "#{title[0]}-" == "reward-" && row[0] == title[1]
            reward = Reward.find_by!(title: title[1])
            Reward.update(reward.id, row.to_h)
          end
        end
      end
    rescue ActiveRecord::RecordNotFound, CSV::MalformedCSVError
    return false
    end
  end
end
