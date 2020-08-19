class AffinityBuilderService
  attr_reader :compute_date

  def initialize(compute_date)
    @compute_date = compute_date
  end

  def self.for(compute_date)
    new(compute_date)
  end

  def compute
    create_affinities
  end

private

  def date_interactions
    Interaction.where(interacted_at: compute_date.beginning_of_day..compute_date.end_of_day).eager_load(:interaction_type)
  end

  # Builds a hash that for each distinct pair of users, returns a list of interactions.
  def user_tuple_interactions
    date_interactions.each_with_object({}) do |interaction, hsh|
      tuple = [interaction.source_user, interaction.target_user].sort
      if hsh.key?(tuple)
        hsh[tuple] << interaction
      else
        hsh[tuple] = [interaction]
      end
    end
  end

  # Calculates and stores the affinity for each tuple of users for the given date.
  def create_affinities
    user_tuple_interactions.map do |tuple, interactions| 
      affinity_strength = interactions.reduce(0) { |strength, interaction| strength += interaction.interaction_type.weight }
      Affinity.create(
        date: compute_date,
        user1: tuple.first,
        user2: tuple.last,
        interactions_count: interactions.count,
        strength: affinity_strength,
      )
    end
  end

end