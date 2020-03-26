class UsersController < ApplicationController
    include SessionHelper

    before_action :authorize, only: [:edit, :update, :destroy]
    
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            session[:current_user_id] = @user.id
            redirect_to user_path(@user)
        else
            @errors = @user.errors.full_messages
            render :new
        end
    end

    def show
        set_user
    end
    
    def edit
        set_user
    end
    
    def update
        set_user
        @user.assign_attributes(user_params)
        if @user.save
            redirect_to user_path(@user)
        else
            @errors = @user.errors.full_messages
            render :edit
        end
    end
    
    def destroy
        set_user
        @user.destroy
        redirect_to users_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end