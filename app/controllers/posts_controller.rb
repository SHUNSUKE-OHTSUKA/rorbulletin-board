class PostsController < ApplicationController
    before_action :logged_in_user, only: [ :new, :create, :edit, :update, :destroy ]

    def index
        @posts = Post.paginate(page: params[:page], per_page: 10)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to posts_path, notice: "投稿に成功しました"
        else
            Rails.logger.info @post.errors.full_messages
            flash.now[:alert] = "投稿に失敗しました"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to posts_path, notice: "更新に成功しました"
        else
            Rails.logger.info @post.errors.full_messages
            flash.now[:alert] = "更新に失敗しました"
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy!
        redirect_to posts_path, status: :see_other, notice: "削除に成功しました"
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
