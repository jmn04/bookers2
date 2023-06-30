class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def show
   @book = Book.find(params[:id])
   @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @books = Book.where(id: params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to "/books"
  end
  
  #ここからプライベート
  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
  
  # 他ユーザーからのアクセス制限
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
end
