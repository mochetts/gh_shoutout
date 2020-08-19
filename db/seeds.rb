# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


##### Users

dhh, tenderlove, llenodo, eileencodes, wycats = %w[dhh tenderlove llenodo eileencodes wycats]

##### Interaction Types

pull_request_comment = InteractionType.create(name: 'PullRequestComment', weight: 10)

##### Interactions

# dhh -> tenderlove
(1..15).to_a.each do |days_ago|
  Interaction.create(source_user: dhh, target_user: tenderlove, interacted_at: days_ago.days.ago, interaction_type: pull_request_comment)
end

# tenderlove -> dhh
(1..4).to_a.each do |days_ago|
  Interaction.create(source_user: tenderlove, target_user: dhh, interacted_at: days_ago.days.ago, interaction_type: pull_request_comment)
end

# dhh -> llenodo
(1..3).to_a.each do |days_ago|
  Interaction.create(source_user: dhh, target_user: llenodo, interacted_at: days_ago.days.ago, interaction_type: pull_request_comment)
end

# dhh -> eileencodes
(1..5).to_a.each do |days_ago|
  Interaction.create(source_user: dhh, target_user: eileencodes, interacted_at: days_ago.days.ago, interaction_type: pull_request_comment)
end

# dhh -> wycats
(1..8).to_a.each do |days_ago|
  Interaction.create(source_user: dhh, target_user: wycats, interacted_at: days_ago.days.ago, interaction_type: pull_request_comment)
end

##### Affinities

# To generate affinities run `$ rails affinities:compute` after the database gets seeded.
