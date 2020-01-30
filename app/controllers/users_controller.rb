class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @posts = user.posts.order("created_at DESC").page(params[:page]).per(3)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :image, :favorite_team)
  end
end
