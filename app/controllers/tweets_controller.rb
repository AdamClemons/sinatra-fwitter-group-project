class TweetsController < ApplicationController

    get '/tweets' do
        # binding.pry
        if !session[:user_id]
            redirect '/login'
        else
            @tweets = Tweet.all
            erb :'tweets/tweets'
        end
    end

    get '/tweets/new' do
        if !session[:user_id]
            redirect '/login'
        else
            erb :'tweets/new'
        end
    end

    post '/tweets' do
        # binding.pry
        Tweet.create(content:params[:content], user_id:session[:user_id])
        redirect '/tweets'
    end

    get '/tweets/:id' do
        # binding.pry
        @tweet = Tweet.find(params[:id])
        @user = User.find(@tweet.user_id)
        erb :'tweets/show_tweet'
    end
end
