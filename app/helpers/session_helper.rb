module SessionHelper

    def authorize
        if !logged_in?
            flash[:warning] = "You must be logged in to do that"
            redirect_to login_path unless logged_in?
        end
    end

    def logged_in?
        !!current_user
    end

    def current_user
        User.find_by(id: session[:current_user_id])
    end
end