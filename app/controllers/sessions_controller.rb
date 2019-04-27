
class SessionsController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      user = User.find_by(email: params[:user][:email])
  
      user = user.try(:authenticate, params[:user][:password])
      puts user
      return redirect_to(controller: 'sessions', action: 'new') unless user
  
      session[:user_id] = user.id
      session[:email] = user.email
  
      @user = user
  
      redirect_to controller: 'home', action: 'home'
    end
  
    def destroy
      session.delete :user_id
      session.delete :email
      redirect_to '/'
    end
  end
  