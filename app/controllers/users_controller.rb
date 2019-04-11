class UsersController < ApplicationController
  # Users [index,show] Books [index,show]の際に投稿が可能なためOnlyで制限している。
	before_action :new_book, only: [:index, :show]
  before_action :authenticate_user!


	def new_book
		@new_book = Book.new
	end

  def index
  	@user = current_user
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	@books = Book.where(user_id: @user.id)
  end

  def edit
  	@user = User.find(params[:id])
  	if @user != current_user
  		redirect_to user_path(current_user)
  	end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :my_image)
  end

end