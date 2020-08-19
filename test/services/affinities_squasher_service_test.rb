require 'test_helper'

class AffinitiesSquasherServiceTest < ActiveSupport::TestCase
  test "#squash should squash all afinities between users for a given timespan" do
    # Build some affinities
    AffinityBuilderService.new(2.days.ago.to_date).compute
    AffinityBuilderService.new(1.days.ago.to_date).compute

    squashed_affinity = AffinitiesSquasherService.for('dhh').squash(from: 2.days.ago, to: 1.day.ago).first
    assert_equal 'tenderlove', squashed_affinity[:user]
    assert_equal 3, squashed_affinity[:interactions_count]
    assert_equal 30, squashed_affinity[:strength]
  end
end
