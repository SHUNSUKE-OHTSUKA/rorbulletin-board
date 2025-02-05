class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SessionsHelper

  private

  ## ログイン済みユーザーか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = "ログインしてください。"
      redirect_to login_url
    end
  end
end
