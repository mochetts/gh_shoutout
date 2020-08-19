class Affinity < ApplicationRecord
  def other_user(user)
    self.user1 == user ? self.user2 : self.user1
  end
end
