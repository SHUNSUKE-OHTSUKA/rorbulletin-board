ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def is_logged_in?
      !session[:user_id].nil?
    end

    # テストユーザーとしてログインする
    def log_in_as(user)
      session[:user_id] = user.id
    end

    # ページ１の画面上の投稿数を返す
    def first_page_posts_count
      Post.paginate(page: 1, per_page: 10).length
    end
  end

  class ActionDispatch::IntegrationTest
    # テストユーザーとしてログインする
    def log_in_as(user, password: "password", remember_me: "1")
      post login_path, params: { session: { email: user.email,
                                            password: password,
                                            remember_me: remember_me } }
    end
  end
end
