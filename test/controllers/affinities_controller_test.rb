require 'test_helper'

class AffinitiesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    # Build some affinities
    AffinityBuilderService.new(2.days.ago.to_date).compute
    AffinityBuilderService.new(1.days.ago.to_date).compute

    get affinities_url, params: { user: 'dhh', from: 2.days.ago.to_date, to: 1.day.ago.to_date }
    assert_response :success

    affinity = JSON.parse(@response.body).first.symbolize_keys
    assert_equal 'tenderlove', affinity[:user]
    assert_equal 3, affinity[:interactions_count]
    assert_equal 30, affinity[:strength]
  end
end
