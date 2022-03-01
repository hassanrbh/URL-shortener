class VisitController < ApplicationController
    def index
        user = User.find_by(id: params[:user_id])
        render :json => user.visits
    end

    def show
        visit = Visit.find_by(:id => params[:user_id])

        render :json => visit
    end
    
    def create
        visit = Visit.new(visit_params)

        if visit.save
            render :json => visit
        else
            render :plain => "Could not create a User"
        end
    end


    protected

    def visit_params
        params.require(:visit).permit(:user_id, :shortener_id)
    end
end