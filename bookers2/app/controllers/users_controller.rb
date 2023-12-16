class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @users = User.all
  end
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "book create successfully"
      redirect_to book_path(@book.id)
    else
      render "./book/index", status: :unprocessable_entity
    end
  end
  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user data update successfully"
      redirect_to user_path(@user.id)
    else
      render "edit", status: :unprocessable_entity
    end
  end
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    if(current_user.id != user.id)
      redirect_to user_path(current_user.id)
    end
  end
end
