class CommentsController < ApplicationController

  before_action :require_login, except: [:index]

  def index
    @comments = Comment.all
  end

  def new
    @comment = current_user.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    @post = @comment.post
    if @comment && @comment.update(comment_params)
      flash[:success] = "Comment was successfully updated."
      redirect_to post_path(@post)
    else
      render 'show'
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    if current_user.admin? || @comment.user == current_user
      @comment = Comment.find(params[:id])
      @post = @comment.post
      @comment.destroy
      flash[:success] = "Comment was successfully deleted."
      redirect_to post_path(@post)
    else
      flash[:error] = "You don't have permission to delete this comment."
      redirect_to post_path(@post)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "Bạn cần đăng nhập để thực hiện hành động này."
      redirect_to new_user_session_path # Chuyển hướng đến trang đăng nhập
    end
  end

end
