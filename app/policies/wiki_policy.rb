class WikiPolicy < ApplicationPolicy
  
 class Scope < Scope

    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(private: false)
      end
    end
 end  

  def destroy?
    user.admin?
  end

  def create?
    user.present?
  end

  def index?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    user.present?
  end

  def show?
   user.present?
  end
end