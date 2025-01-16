require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(title: "Example Post", content: "This is an example post.")
  end

  test "should be valid" do
    assert @post.valid?
  end
end
