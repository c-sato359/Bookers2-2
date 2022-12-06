class UsersController < ApplicationController
  # 投稿データの保存
  def create
    @profile_image = Profile_Image.new(profile_image_params)
    @profile_image.user_id = current_user.id
    if @profile_image.save
      redirect_to profile_images_path
    else
      render user_path(current)
    end
    unless @user == current_user
     redirect_to user_path(current_user)
    end
    if @user.save
      redirect_to user_session_path
    end
  end


  def index
   
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    if current_user.nil?
    redirect_to user_session_path
    end
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user =User.find(params[:id])
    unless @user == current_user
     redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
       redirect_to user_path(user.id)
    else
      render "edit"
    end
  end

 
  
  private

  def user_params
    params.require(:user).permit(:name,  :introduction, :profile_image)
  end
end
