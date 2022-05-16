# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  def update?
    user.first_name.nil? && user.last_name.nil?
  end

  def permitted_attributes
    if user.first_name.nil? && user.last_name.nil?
      %i[first_name last_name]
    else
      %i[first_name last_name email password]
    end
  end
end
