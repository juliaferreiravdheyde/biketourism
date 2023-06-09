class RoutePolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def record?
    register? && record.name.nil?
  end

  def register?
    record.creator == user
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    record.creator == user
  end

  def edit_description?
    record.creator == user
  end

  def delete_photo?(photo)
    return false if user.nil?

    photo.metadata[:user_id] == user.id || record.creator == user
  end
end
