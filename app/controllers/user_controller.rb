class UserController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        @user = User.all
        render :index
    end
    def show
        @user = User.find_by(:id => params[:id])
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            redirect_to user_url(@user)
        else
            # redirect_to new_user_url
            # render :new
            render plain: @user.errors.full_messages , status: :unprocessable_entity 
        end
    end

    def destroy
        @user = User.find_by(:id => params[:id]) 
        @user.destroy
        redirect_to new_user_url    
    end

    def videos
    end
    # A Passlist
    private

    def user_params
        params.require(:user).permit(:email, :premium)
    end
end