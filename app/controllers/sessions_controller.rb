require 'pry'
class SessionsController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      user = User.find_by(email: params[:user][:email])
  
      user = user.try(:authenticate, params[:user][:password])
      return redirect_to(controller: 'sessions', action: 'new') unless user
  
      session[:user_id] = user.id
      session[:email] = user.email
  
      @user = user
  
      redirect_to controller: 'home', action: 'home'
    end
    
    def createfacebook

      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.email = auth['info']['email']
        u.password=auth['uid']
      end
      
      
      session[:user_id] = @user.id
      session[:email] = @user.email
      redirect_to controller: 'home', action: 'home'
    end

    def destroy
      session.delete :user_id
      session.delete :email
      redirect_to '/'
    end

    private

    private

    def auth
      request.env['omniauth.auth']
    end

  end
  