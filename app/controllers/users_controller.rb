class UsersController < ApplicationController
  before_action :require_login, except: [:resetPassword]
  
  def index
    run User::Operation::Index do |result|
      @users = result[:users].paginate(:page=>params[:page] , per_page: 5)
    end
  end

  def new
    @form = User.new
  end

  def show
    run User::Operation::Edit
    @user = result["model"]
  end

  def edit
    run User::Operation::Edit
    @user = result["model"]
  end

  def create
    run User::Operation::Create do |result|
      return redirect_to users_list_path,notice: "User is saved successfully!"
    end
    render :new
  end

  def search_user
    @searchKey = params[:searchInfo]
    run User::Operation::Search do |result|
      @users = result[:users].paginate(:page=>params[:page],per_page: 5)
      render :index
      return
    end
  end

  def update
    if params[:user]
      puts (params[:user])
    else 
      params[:user] = params[:user_contract_update]
    end
    _ctx = run User::Operation::Update do |result| 
      return redirect_to users_show_path('id'=>params[:user][:id]), notice: "User updated successfully!"
    end
    @user   = _ctx["contract.default"] 
    @name  = "Editing #{_ctx[:model].name}"
    @email  = "Editing #{_ctx[:model].email}"
    @phone  = "Editing #{_ctx[:model].phone}"
    render :edit
  end

  def destroy 
    run User::Operation::Destroy do |_|
      return redirect_to users_list_path, notice: "User deleted successfully!"
    end  
  end

  def profile
    run User::Operation::Edit
    @user = result["model"]
  end

  def editPassword
    run User::Operation::Edit
    @user = result["model"]
  end

  def editProfile
    run User::Operation::Edit
    @user = result["model"]
  end

  def updatePassword
    if params[:user]
      puts (params[:user])
    else 
      params[:user] = params[:user_contract_update_password]
    end
    _ctx = run User::Operation::UpdatePassword do |result| 
      return redirect_to users_profile_path('id'=>params[:user][:id]), notice: "Password updated successfully!"
    end
    @user   = _ctx["contract.default"] 
    @password  = "Editing #{_ctx[:model].password}"
    @password_confirmation  = "Editing #{_ctx[:model].password_confirmation}"
    render :editPassword
  end

  def updateProfile
    if params[:user]
      puts (params[:user])
    else 
      params[:user] = params[:user_contract_update]
    end
    _ctx = run User::Operation::Update do |result| 
      return redirect_to users_profile_path('id'=>params[:user][:id]), notice: "Profile updated successfully!"
    end
    @user   = _ctx["contract.default"] 
    @name  = "Editing #{_ctx[:model].name}"
    @email  = "Editing #{_ctx[:model].email}"
    @phone  = "Editing #{_ctx[:model].phone}"
    render :editProfile 
  end

end
