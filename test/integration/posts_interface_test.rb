require "test_helper"

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:one)
  end

  test "posts interface" do
    log_in_as(@user)
    # index表示
    get posts_path
    # puts response.parsed_body # デバッグ用
    assert_template "posts/index"
    assert_select ".pagination", count: 2
    # 新規投稿（無効）
    assert_no_difference "Post.count" do
      post posts_path, params: { post: { title: "", content: "" } }
    end
    assert_template "posts/new"
    assert_select "div.alert-danger"
    # 新規投稿（有効）
    assert_difference "Post.count", 1 do
      post posts_path, params: { post: { title: "integration_test", content: "integration_test" } }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_template "posts/index"
    Post.find_each do |post|
      if post.title.include?("integration_test") || post.content.include?("integration_test")
        @new_post = post
        break
      end
    end
    # 投稿編集
    get edit_post_path(@new_post)
    assert_template "posts/edit"
    patch post_path(@new_post), params: { post: { title: "integration_test_edit", content: "integration_test_edit" } }
    assert_redirected_to posts_path
    follow_redirect!
    assert_template "posts/index"
    @new_post.reload
    assert_equal "integration_test_edit", @new_post.title
    assert_equal "integration_test_edit", @new_post.content
    # 投稿削除
    assert_difference "Post.count", -1 do
      delete post_path(@new_post)
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_template "posts/index"
  end
end
