module ApplicationHelper
  def admin?(user)
    return user.admin_status if user

    nil
  end
end
