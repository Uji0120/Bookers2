class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id),  flash: {success: "You have created book successfully." }
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), flash: {success: "You have updated book successfully." }
    else
      #@book = Book.find(params[:id])
      render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end

end
