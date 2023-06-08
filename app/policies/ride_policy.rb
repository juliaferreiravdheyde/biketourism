class RidePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  
  def create?
    true
  end

  def mark_as_done?
    true
  end

  def destroy?
    record.creator == user
  end
end
