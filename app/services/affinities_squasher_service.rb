# Service in charge of squashing the affinities between a specified user 
# and the rest of the users within a given date range.
class AffinitiesSquasherService
  attr_reader :user, :date_from, :date_to

  def initialize(user)
    @user = user
  end

  def self.for(user)
    new(user)
  end

  def squash(from:, to:)
    @date_from = from.is_a?(String) ? Date.parse(from) : from
    @date_to = to.is_a?(String) ? Date.parse(to) : to

    squash_affinities

    sqashed_affinities.map { |related_user, squashed_data| { user: related_user, **squashed_data } }
  end


private

  def user_affinities
    Affinity.where(date: date_from.beginning_of_day..date_to.end_of_day).where(["user1 = :user or user2 = :user", { user: user }])
  end

  def squash_affinities
    user_affinities.each { |affinity| 
      related_user = affinity.other_user(user)
      sqashed_affinities_for(related_user)[:interactions_count] += affinity.interactions_count
      sqashed_affinities_for(related_user)[:strength] += affinity.strength
    }
  end

  def sqashed_affinities
    @sqashed_affinities ||= {}
  end

  def sqashed_affinities_for(related_user)
    sqashed_affinities[related_user] ||= {
      interactions_count: 0,
      strength: 0,
    }
  end

end