class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(body: '')
      end
    end
  end

  def index?
    true
 end

 def show?
    true
 end

 def create?
    user.admin?
 end

 def update?
    # user.present? && (record.user_id == user.id)
    user.admin?
 end

 def destroy?
    user.present? && (record.user_id == user.id)
 end
end
