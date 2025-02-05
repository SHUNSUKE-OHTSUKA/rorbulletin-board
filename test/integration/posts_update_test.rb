require "test_helper"

class PostsUpdateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:one)
  end

  test "should update a post" do
    log_in_as(@user)
    get edit_post_path(@post)
    patch post_path(@post), params: { post: { title: "test", content: "test" } }
    follow_redirect!
    assert_template "posts/index"
    assert_not flash.empty?
  end

  test "should not update a post" do
    log_in_as(@user)
    get edit_post_path(@post)
    patch post_path(@post), params: { post: { title: "", content: "" } }
    assert_template "posts/edit"
    assert_not flash.empty?
  end
end
