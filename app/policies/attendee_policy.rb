class AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def checkin?
    user.present?
  end

  def uncheckin?
    user.present?
  end

  def reissue?
    user.present?
  end

  def eject?
    user.present?
  end
end
