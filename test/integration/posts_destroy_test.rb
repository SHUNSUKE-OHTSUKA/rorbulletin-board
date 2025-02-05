require "test_helper"

class PostsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:one)
  end

  test "should destroy a post" do
    log_in_as(@user)
    get posts_path
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    follow_redirect!
    assert_template "posts/index"
    assert_not flash.empty?
  end
end
