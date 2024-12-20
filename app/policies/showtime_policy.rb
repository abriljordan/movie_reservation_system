class ShowtimePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    true # All users can view showtimes
  end

  def show?
    true # All users can view showtime details
  end

  def create?
    user.admin? # Only admins can create showtimes
  end

  def update?
    user.admin? # Only admins can update showtimes
  end

  def destroy?
    user.admin? # Only admins can delete showtimes
  end

  def report?
    user.admin? # Only admins can view showtime reports
  end
  
end
