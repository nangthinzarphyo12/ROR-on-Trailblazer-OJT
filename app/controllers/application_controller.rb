class ApplicationController < ActionController::Base

    def current_user
        if session[:id]
            run User::Operation::Edit
            @current_user = User.find_by(id: session[:id])
        else
            redirect_to login_path, notice: "You must be logged in to access this section."
        end
    end

    def logged_in?
        current_user
    end

    def require_login
        redirect_to '/posts/index' unless logged_in?
    end

end
