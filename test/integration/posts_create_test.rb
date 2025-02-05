require "test_helper"

class PostsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "should create a new post" do
    log_in_as(@user)
    get new_post_path
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { title: "test", content: "test" } }
    end
    follow_redirect!
    assert_template 'posts/index'
    assert_not flash.empty?
  end

  test "should not create a new post" do
    log_in_as(@user)
    get new_post_path
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: "", content: "" } }
    end
    assert_template 'posts/new'
    assert_not flash.empty?
  end
end
