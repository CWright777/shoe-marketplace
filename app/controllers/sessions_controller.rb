class SessionsController < ApplicationController

  def index
    @session = Session.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:error] = "Invalid email or password"
        redirect_to '/'
      end
  end

  def destroy
    reset_session
    redirect_to '/'
  end

end
