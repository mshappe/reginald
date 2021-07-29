# frozen_string_literal: true

class AttendeeNotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.none
    end
  end

  def new?
    user&.has_any_role? :staff, :helpdesk, :head, :admin
  end

  def create?
    new?
  end
end
