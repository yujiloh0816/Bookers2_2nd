class BooksController < ApplicationController
  # Users [index,show] Books [index,show]の際に投稿が可能なためOnlyで制限している。
	before_action :new_book, only: [:index, :show]
  before_action :authenticate_user!


	def new_book
		@new_book = Book.new
	end

	def create
		@new_book = Book.new(book_params)
		@new_book.user_id = current_user.id
		if @new_book.save
  		redirect_to book_path(@new_book), notice: "You have posted the book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
  	@user = current_user
  	@books = Book.all
  end

  def show
  	if Book.exists?(id: params[:id])
  		@book = Book.find(params[:id])
  		@user = @book.user
  	else
  		redirect_to books_path
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
  	book = Book.find(params[:id])
  	book.update(book_params)
  	redirect_to book_path(book), notice: "You have updated the book successfully."
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "You have deleted the book successfully."
  end

  private
  	def book_params
  		params.require(:book).permit(:title, :opinion)
  	end

end
