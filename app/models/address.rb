class Address < ApplicationRecord
  validates :street, :postcode, :city, presence: true

  belongs_to :order, inverse_of: :address
end
