class LoginController < ApplicationController
  def login
    
  end

  def attempt_login
    if params[:email].blank?
      flash[:notice] = "Email is required"
      redirect_to login_path
    elsif params[:password].blank?
      flash[:notice] = "Password is required"
      redirect_to login_path
    else
      @user = UserService.getUserByEmail(params[:email])
      if @user
        authorized_user = @user.authenticate(params[:password])
        if authorized_user
          session[:email] = @user.email
          session[:id] = @user.id
          redirect_to(controller:'posts' ,:action => 'index')
        else
          flash[:notice] = "Please check your email and password !"
          redirect_to login_path
        end
      else
        flash[:notice] = "Please check your email and password !"
        redirect_to login_path
      end
    end
  end

  def logout
    session.delete(:id)
    session.delete(:email)
    flash[:notice] = "You have logged out"
    redirect_to(:action => 'login')
  end

end
