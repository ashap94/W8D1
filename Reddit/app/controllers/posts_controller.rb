class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if current_user.id == @post.user_id && @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end

  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
