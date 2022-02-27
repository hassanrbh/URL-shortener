class SillyController < ApplicationController
    protect_from_forgery with: :null_session
    def fun
        render :json => params[:password], :status => 200
    end 
    
    def aya
        render :json => params
    end
end