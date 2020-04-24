class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
     @user = User.find_by(id: params[:id])
     if @user
       @microposts = @user.microposts.order(id: :desc).page(params[:page])
       counts(@user)
     else
       redirect_user_not_found
     end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  
  def followings
    @user = User.find_by(id: params[:id])
    if @user
    @followings = @user.followings.page(params[:page])
    counts(@user)
    else
     redirect_user_not_found
    end
  end
  
  def followers
    @user = User.find_by(id: params[:id])
    if @user
    @followers = @user.followers.page(params[:page])
    counts(@user)
    else
      redirect_user_not_found
    end
  end
  
  
  def likes
    @user = User.find_by(id: params[:id])
    if @user
    @likes = @user.likes.page(params[:page])
    counts(@user)
    else
      redirect_user_not_found
    end
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def redirect_user_not_found
    flash[:danger] = "存在しないユーザIDです"
    redirect_to root_path
  end
end
