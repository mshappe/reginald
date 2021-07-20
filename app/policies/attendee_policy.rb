class AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user&.has_any_role? :staff, :head, :admin
      scope.all
    end
  end

  def index?
    blessed?
  end

  def show?
    blessed?
  end

  def edit?
    blessed?
  end

  def update?
    blessed?
  end

  def checkin?
    blessed?
  end

  def uncheckin?
    blessed?
  end

  def reissue?
    blessed?
  end

  def eject?
    super_blessed?
  end

  protected

  def blessed?
    user&.has_any_role? :staff, :head, :admin
  end

  def super_blessed?
    user&.has_any_role? :head, :admin
  end
end
