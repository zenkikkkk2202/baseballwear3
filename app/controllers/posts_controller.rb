class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search, :top]
  

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page]).per(3)
  end

  def top 
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).last(3).reverse
  end

  def edit    
    @post = Post.find(params[:id])
  end

  def update
     post = Post.find(params[:id])
     post.update(post_params)
     redirect_to posts_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(3)
  end


  private
    def post_params
      params.require(:post).permit(:text,:image,:team).merge(user_id: current_user.id)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

end
