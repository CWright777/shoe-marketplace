class ShoesController < ApplicationController
  def index
    @user = current_user
    @shoes = Shoe.all.where("user_id != ? AND created_at = updated_at", current_user)
  end

  def create
    @shoe = Shoe.new(shoe_params)
    unless @shoe.save
      flash[:errors] = @shoe.errors.full_messages
    end
    redirect_to :back
  end

  def update
    Shoe.find(params[:id]).update_attribute(:buyer_id, session['user_id'])
    redirect_to :back
  end

  def destroy
    Shoe.find(params[:id]).destroy
    redirect_to :back
  end

  private
    def shoe_params
      params.require(:shoe).permit(:name,:price).merge(user:current_user,buyer_id:nil)
    end
end
