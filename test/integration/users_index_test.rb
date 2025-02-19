require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
    @non_activated = users(:non_activated)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select ".pagination", count: 2
    # puts response.parsed_body # デバッグ用
    # puts User.where(activated: true).paginate(page: 1, per_page: 10).pluck(:id, :name) # デバッグ用
    first_page_of_users = User.where(activated: true).paginate(page: 1, per_page: 10)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "削除"
      end
    end
    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a", text: "削除", count: 0
  end

  test "should not show non activated user" do
    log_in_as(@admin)
    get users_path
    assert_select "a[href=?]", user_path(@non_activated), count: 0
    get user_path(@non_activated)
    assert_redirected_to root_url
  end
end
