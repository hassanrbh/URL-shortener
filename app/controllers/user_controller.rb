class UserController < ApplicationController
    protect_from_forgery with: :null_session
    def index 
        render :json => User.all
    end
    def show
        user = User.find_by(:id => params[:user_id])
        
        render :json => user.to_json
    end

    def create
        new_user = User.new(user_params)

        if new_user.save
            render :json => new_user.to_json
        else
            render :json => "Can't Create A Duplicate User, sorry "
        end
    end
    
    def delete
        user = User.find_by(:id => params[:user_id])
        
        if user.destroy
            render :json => user.to_json
        else
            render :json => "Can't delete this user, in some circumstances"
        end
    end

    def user_params
        params.require(:user).permit(:email, :premium)
    end
end