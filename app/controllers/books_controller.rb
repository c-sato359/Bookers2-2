class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    
    @book = Book.find(parmas[:id])
    @user = User.find(@book.user_id)
  end

  def new
    @book = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_paramas)
    @book.user_id = current_user.id
    
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render "books/index"
    end
  end
  
  def edit
    @book = Book.find(paramas[:id])
    @user =User.find(@book.user_id)
    
    if @user.id == current_user.id
      render :edit
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(paramas[:id])
    if @book.update(book_paramas)
      flash[:notice] = "You have update book successfully."
       redairect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(parmas[:id])
    @book.destroy
    redirect_to books_path
  end 
  
  private
  def book_paramas
     paramas.require(:book).permit(:title, :body)
  end
end
