class UsersController < ApplicationController

  def index
    render json: users
  end

private

  def users
    Affinity.select(:user1, :user2).pluck(:user1, :user2).flatten.uniq
  end

end
