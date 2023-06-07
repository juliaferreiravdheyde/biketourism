class RoutePolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      scope.all
    end

    def show?
      true
    end

    def create?
      true
    end

    def update?
      record.creator == user
    end

    def edit?
      update?
    end

    def destroy?
      record.user == user
    end
  end
end