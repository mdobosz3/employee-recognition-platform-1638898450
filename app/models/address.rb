class Address < ApplicationRecord
  validates :street, :postcode, :city, presence: true

  belongs_to :order
end
