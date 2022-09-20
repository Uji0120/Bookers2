class UsersController < ApplicationController

  #before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash.now[:notice] ="Signed in successfully."
      redirect_to books_path
    else
      render :new
    end
  end

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @book = Book.new
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
   else
     redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), flash: {notice: "You have updated user successfully."}
    else
    #@user = User.find(params[:id])
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to user_path(@user.id) unless @user == current_user
  end

end
