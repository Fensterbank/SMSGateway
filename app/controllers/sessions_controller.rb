class SessionsController < ApplicationController
  def new

  end

  def create
    if params[:password] == APP_CONFIG['password']
      session[:valid] = true
      redirect_to send_message_path
    else
      render 'new'
    end
  end

  def destroy
    session[:valid] = nil
    redirect_to root_path
  end
end
