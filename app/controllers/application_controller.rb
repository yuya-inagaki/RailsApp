class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    # ログインしていないユーザー
    def authenticate_user
        if @current_user == nil
            redirect_to(login_path)
        end
    end
    
    # ログイン中のユーザー
    def forbid_login_user
        if @current_user
            redirect_to(user_path(@current_user))
        end
    end
end
