module ProfileHelper
  def user_wants(user)
    return User.looking_for?(user)
  end

  def barter_amount(user)
    user_id = user.id
    barters = Offer.where("user1_id = ? OR user2_id = ? AND accepted = ?", user_id, user_id, true) 
    return barters.length
  end
end
