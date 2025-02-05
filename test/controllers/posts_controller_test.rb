require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  test "should get index when not logged in" do
    get posts_path
    assert_response :success
  end

  test "should get new when not logged in" do
    get new_post_path
    assert_redirected_to login_url
  end

  test "should create post when not logged in" do
    assert_no_difference "Post.count" do
      post posts_path, params: { post: { title: "test", content: "test" } }
    end
    assert_redirected_to login_path
  end

  test "should get edit when not logged in" do
    get edit_post_path(@post)
    assert_redirected_to login_url
  end

  test "should update post when not logged in" do
    patch post_path(@post), params: { post: { title: @post.title, content: @post.content } }
    assert_redirected_to login_url
  end

  test "should destroy post when not logged in" do
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end
end
