# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :given_kudo, class_name: "Kudo", foreign_key: 'giver_id', dependent: :destroy, inverse_of: :kudo
  has_many :receiven_kudo, class_name: "Kudo", foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :kudo
end
