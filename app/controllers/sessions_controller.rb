class SessionsController < ApplicationController

    def create
        @user= User.find_by(username: params[:user][:username])
        if @user and BCrypt::Password.new(@user.password) == params[:user][:password]
            session = @user.sessions.create
            cookies.permanent.signed[:twitter_session_token] ={
                value: session.token,
                httonly: true
            }
            render json: {
                success: true
            }
            else
                render json: {
                    success: false
            }
        end
    end


end
