class UsersController < ApplicationController

  def index
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @non_purchased = current_user.shoes.where("created_at = updated_at")
    @purchased = current_user.shoes.where.not("created_at = updated_at")
    @purchases = Shoe.all.where("buyer_id = ?", session[:user_id])
    @shoes = Shoe.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/'
    end

  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
