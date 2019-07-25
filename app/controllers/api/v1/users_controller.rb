
module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: [:login, :register,:index,:show]
      before_action :set_user, only: [:show,:update,:destroy]
      def login
        authenticate params[:email], params[:password]
      end
      def register
        @user = User.create(user_params)
       if @user.save
        response = { message: 'User created successfully'}
        render json: response, status: :created
       else
        render json: @user.errors, status: :bad
       end
      end
      def index
        @users = User.all
        render json: @users
      end
      def show
        render json: @user
      end
      def update
        if @current_user.role == "admin" && @user.update(user_params)
          render json: @user
        end
      end
      def destroy
        if @current_user.role == "admin" && @current_user.id != @user.id
          @user.destroy
          render json: "Success"
        else
          render json: "Failure"
        end
      end
      private
      def authenticate(email, password)
        command = AuthenticateUser.call(email, password)

        if command.success?
          render json: {
            access_token: command.result,
            message: 'Login Successful'
          }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
       end
      def set_user
        @user = User.find(params[:id])
      end
      def user_params
        params.permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
