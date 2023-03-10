class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = Post.new(post_parameters)
    if @post.save
      flash[:success] = 'post added successfully'
      redirect_to user_posts_path(current_user)
    else
      flash[:success] = 'post was not added'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_parameters
    params.require(:new_post).permit(:title, :text)
  end
end
