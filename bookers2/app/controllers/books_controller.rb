class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
  end
  def show
    @book = Book.new
    @book_another = Book.find(params[:id])
  end
  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "book create successfully"
      redirect_to book_path(@book.id)
    else
      render "index", status: :unprocessable_entity
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "book update successfully"
      redirect_to book_path(@book.id)
    else
      render "edit", status: :unprocessable_entity
    end
  end
  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    user = Book.find(params[:id]).user
    if(current_user.id != user.id)
      redirect_to books_path
    end
  end
end
