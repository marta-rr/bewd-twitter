class TweetsController < ApplicationController

    def create
        token = cookies.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        if session
            user = session.user
            @tweet = user.tweets.new(tweet_params)

            if @tweet.save
                render 'tweets/create'
            else
                render json: {
                    success: false
                }
            end
        else
            render json: {
                success:  false
            }
        end
    end

    def destroy
        token = cookies.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        @tweet = Tweet.find_by(id: params[:id])

        if session and @tweet and @tweet.destroy
           render json: {
               success: true
           }
        else
            render json: {
                success: false
            }
        end
    end

    def index
        @tweets = Tweet.all.order("id DESC")
        render 'tweets/index'
    end

    private
    def tweet_params
        params.require(:tweet).permit(:message)
    end

end
