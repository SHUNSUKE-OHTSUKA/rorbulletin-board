class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "アカウントが有効化されていません。"
        message += "メールを確認してください。"
        flash[:alert] = message
        redirect_to root_url
      end
    else
      flash.now[:alert] = "mailアドレスまたはパスワードが間違っています"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other, notice: "ログアウトしました"
  end
end
