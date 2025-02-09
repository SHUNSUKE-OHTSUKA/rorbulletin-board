require "test_helper"

class PostsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @post = posts(:one)
  end

  test "should destroy a post" do
    log_in_as(@admin)
    get posts_path
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    follow_redirect!
    assert_template "posts/index"
    assert_not flash.empty?
  end

  test "should not destroy a post" do
    log_in_as(@non_admin)
    get posts_path
    assert_difference "Post.count", 0 do
      delete post_path(@post)
    end
    follow_redirect!
    assert_template "posts/index"
    assert_not flash.empty?
  end
end
