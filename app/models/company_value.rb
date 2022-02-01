# frozen_string_literal: true

class CompanyValue < ApplicationRecord
  validates :title, presence: true

  has_many :kudos, class_name: 'Kudo', foreign_key: 'company_value_id', inverse_of: :kudo
end
