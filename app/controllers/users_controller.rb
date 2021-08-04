class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.id
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "Unprocessable Entity"}, status: :unprocessable_entity
        end
    end

    def show
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user
        else
            render json: {error: "NOT AUTHORIZED"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
