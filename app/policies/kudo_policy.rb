# frozen_string_literal: true

class KudoPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    Time.zone.now - record.created_at < 5.minutes
  end

  def destroy?
    update?
  end
end
