# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user&.has_any_role? :admin, :head

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

  def bless?
    blessed?
  end

  def curse?
    blessed?
  end

  def permitted_attributes
    %i[name role] if blessed?
  end

  protected

  def blessed?
    user.has_any_role? :admin, :head
  end
end
