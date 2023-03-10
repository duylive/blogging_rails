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
    if @comment.update(comment_params)
      flash[:success] = "Comment was successfully updated."
      redirect_to post_path(@post)
    else
      render 'show'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment was successfully deleted."
    redirect_to post_path(@post)
  end

  private

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
