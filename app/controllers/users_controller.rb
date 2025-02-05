class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :correct_user,   only: [ :edit, :update ]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_url, notice: "メールを確認してアカウントを有効化してください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "更新が完了しました。"
    else
      Rails.logger.info @user.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, status: :see_other, notice: "ユーザーを削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeアクション
  ## 正しいユーザーか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  ## 管理者か確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
