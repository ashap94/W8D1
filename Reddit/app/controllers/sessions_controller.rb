class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by_credentials(username, password)

    if user
      login!(user)
      redirect_to subs_url
    else
      flash.now[:errors] = ['wrong credentials']
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
  
end
