class PasswordController < ApplicationController
    def reset
        
    end

    def create
        @user = UserService.getUserByEmail(params[:email])
        if @user
            PasswordMailer.with(user:@user).reset.deliver_now
            # @user.send_password_reset
            
            redirect_to password_reset_path, :notice => "Email sent with password reset instructions."
        else
            redirect_to password_reset_path,notice:"We did not find this email."
        end
    end

    def edit
        @user = User.find_signed!(params[:token], purpose:"password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to login_path, notice:"Your token has expired.Please try again."
    end

    def update
        @user = User.find_signed!(params[:token], purpose:"password_reset")
        if password_params[:password].blank?
            flash[:notice] = "Password is required"
            render :edit
        elsif password_params[:password_confirmation].blank?
            flash[:notice] = "Confirm password is required"
            render :edit
        else
            isUpdated = UserService.updateUser(password_params,@user)
            if isUpdated
                redirect_to password_reset_path, alert:"Your password was reset successfully.Please sign in."
            else
                render :edit
            end
        end
    end

    private
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end