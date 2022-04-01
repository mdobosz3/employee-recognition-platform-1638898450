class KudoPolicy < ApplicationPolicy

  def edit?
    update?
  end

  def update?
    Time.now - record.created_at < 5.minutes
  end

  def destroy?
    update?
  end

  end
