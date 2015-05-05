module ProfileHelper
  def user_wants(user)
    return User.looking_for?(user)
  end
end
