class FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.includes(:route).where(user: user)
    end
  end

  def create?
    true
  end

  # def destroy?
  #   record.creator == user
  # end
end
