class PasswordController < ApplicationController
    def reset
        
    end

    def create
        run User::Operation::SendEmail
        @user = result[:user]
        if @user
            PasswordMailer.with(user:@user).reset.deliver_now
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
        @userP = User.find_signed!(params[:token], purpose:"password_reset")
        if params[:user]
            params[:id] = params[:user][:id]
        else
            params[:user] = params[:user_contract_update_password]
            params[:id] = params[:user][:id]
        end
        _ctx = run User::Operation::UpdatePassword do |result| 
            return redirect_to password_reset_path, alert:"Your password was reset successfully.Please sign in."
        end
        @user   = _ctx["contract.default"]
        @password  = "Editing #{_ctx[:model].password}"
        @password_confirmation  = "Editing #{_ctx[:model].password_confirmation}"
        render :edit
    end
end