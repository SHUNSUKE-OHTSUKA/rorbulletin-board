require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = Post.new(title: "Example Post", content: "This is an example post.", user_id: @user.id)
  end

  test "should be valid" do
    assert @post.valid?
  end
end
