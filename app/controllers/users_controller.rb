class UsersController < ApplicationController
  def index
    if current_user.nil?
    redirect_to user_session_path
    end
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
    if current_user.nil?
      redirect_to user_session_path
      
    elsif @user != current_user
     redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_paramas)
      flash[:notice] = "You have updated user successfully."
       redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  private
  def user_paramas
    paramas.require(:user).permit(:name,  :introduction, :profile_image)
  end 
  def book_paramas
    paramas.permit(:title, :body, :user_id)
  end
end
