class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {error: "Invalid Username and Password"}, status: :unauthorized
        end
    end

    def destroy
        session.delete :user_id
    end
end
