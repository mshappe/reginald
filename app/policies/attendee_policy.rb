# frozen_string_literal: true

class AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user&.has_any_role? :read_only, :staff, :head, :admin

      scope.all
    end
  end

  def index?
    semi_charmed? || blessed?
  end

  def show?
    semi_charmed? || blessed?
  end

  def new?
    super_blessed?
  end

  def create?
    super_blessed?
  end

  def edit?
    user&.can_transfer?
  end

  def update?
    user&.can_transfer?
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

  def importer?
    import?
  end

  def import?
    user&.has_role? :admin
  end

  protected

  def semi_charmed?
    user&.has_any_role? :read_only
  end

  def blessed?
    user&.has_any_role? :staff, :helpdesk, :head, :admin
  end

  def super_blessed?
    user&.has_any_role? :head, :admin
  end
end
