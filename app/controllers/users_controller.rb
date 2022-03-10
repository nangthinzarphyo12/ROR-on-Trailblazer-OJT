class UsersController < ApplicationController
  before_action :require_login, except: [:resetPassword]
  
  def index
    alluser = UserService.getAllUsers
    @per_page = 5
    @users= alluser.paginate(:page=>params[:page] , per_page:@per_page)
    if params[:page].blank?
      @page = 1
    else
      @page = params[:page].to_i
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = UserService.getuserByID(params[:id])
  end

  def edit
    @user = UserService.getuserByID(params[:id])
  end

  def create
    @user = User.new(user_params)
    user = UserService.insertUser(@user)
    if user
      redirect_to users_list_path, notice: "User created successfully!"
    else
      render :new 
    end
  end

  def update
    @user = UserService.getuserByID(user_params[:id])
    isUpdated = UserService.updateUser(user_params,@user)
    if isUpdated 
      redirect_to users_show_path('id'=>user_params[:id]), notice: "User updated successfully!"
    else
      render :edit
    end 
  end

  def destroy
    isDeleted = UserService.deleteUser(params[:id])
    if isDeleted 
      redirect_to users_list_path, notice: "User deleted successfully!"
    else
      render :destroy
    end   
  end

  def profile
    @user = UserService.getuserByID(params[:id])
  end

  def editPassword
    @user = UserService.getuserByID(params[:id])
  end

  def editProfile
    @user = UserService.getuserByID(params[:id])
  end

  def updatePassword
    @user = UserService.getuserByID(user_params[:id])

    if user_params[:password].blank?
      flash[:notice] = "Password is required"
      render :editPassword
    elsif user_params[:password_confirmation].blank?
      flash[:notice] = "Confirm password is required"
      render :editPassword
    else
      isUpdated = UserService.updateUser(user_params,@user)
      if isUpdated 
        redirect_to users_profile_path('id'=>user_params[:id]), notice: "Password updated successfully!"
      else
        render :editPassword
      end
    end
  end

  def updateProfile
    @user = UserService.getuserByID(user_params[:id])
    isUpdated = UserService.updateUser(user_params,@user)
    if isUpdated 
      redirect_to users_profile_path('id'=>user_params[:id]), notice: "Profile updated successfully!"
    else
      render :editProfile
    end 
  end

  private
  def user_params
    params.require(:user).permit(:id ,:name ,:email ,:password , :password_confirmation,:phone , :role,:created_by ,:updated_by)
  end

  private
  def user_form_params
    params.require(:user).permit(:id ,:name ,:email ,:phone , :role,:created_by ,:updated_by)
  end

end
