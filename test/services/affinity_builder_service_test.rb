require 'test_helper'

class AffinityBuilderServiceTest < ActiveSupport::TestCase
  test "compute should create affinities between users" do
    AffinityBuilderService.new(2.days.ago.to_date).compute
    assert_equal 1, Affinity.count

    affinity = Affinity.first
    assert_equal 20, affinity.strength
    assert_equal 2, affinity.interactions_count
  end
end
