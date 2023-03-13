class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    # @post = Post.find_by id: params[:id]
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post was successfully created."
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfully updated."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.admin? || @post.user == current_user
      @post.destroy
      flash[:success] = "Post was successfully deleted."
      redirect_to posts_url
    else
      flash[:error] = "You don't have permission to delete this post."
      redirect_to posts_url
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "Bạn cần đăng nhập để thực hiện hành động này."
      redirect_to new_user_session_path # Chuyển hướng đến trang đăng nhập
    end
  end
end
