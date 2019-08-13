class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      login!(user)
      redirect_to subs_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end

  end

  def delete
    user = User.find(params[:id])
    logout!
    user.destroy
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
