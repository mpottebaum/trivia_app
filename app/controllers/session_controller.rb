class SessionController < ApplicationController

    def new
    end

    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:current_user_id] = user.id
            redirect_to user_path(user)
        else
            flash[:error] = "Your username or password were not correct"
            render :new
        end
    end

    def destroy
        session.delete :current_user_id
        redirect_to login_path
    end
end