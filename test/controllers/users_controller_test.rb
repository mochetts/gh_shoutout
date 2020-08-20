require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    # Build some affinities
    AffinityBuilderService.new(2.days.ago.to_date).compute
    AffinityBuilderService.new(1.days.ago.to_date).compute

    get users_url
    assert_response :success

    users = JSON.parse(@response.body)
    assert_equal 2, users.count
    assert_equal ["dhh", "tenderlove"], users
  end
end
