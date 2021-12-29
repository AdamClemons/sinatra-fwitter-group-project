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
        if params[:content].empty?
            redirect '/tweets/new'
        else
            Tweet.create(content:params[:content], user_id:session[:user_id])
            redirect '/tweets'
        end
    end

    get '/tweets/:id' do
        # binding.pry
        if session[:user_id]
            @tweet = Tweet.find(params[:id])
            @user = User.find(@tweet.user_id)
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id' do
        if session[:user_id] == Tweet.find(params[:id]).user.id
            Tweet.find(params[:id]).destroy
        end
        redirect '/tweets'
    end

    get '/tweets/:id/edit' do
        if !session[:user_id]
            redirect '/login'
        else
            if session[:user_id] == Tweet.find(params[:id]).user.id
                @tweet = Tweet.find(params[:id])
                erb :'tweets/edit_tweet'
            else
                redirect '/tweets'
            end
        end
    end

    patch '/tweets/:id' do
        if session[:user_id] == Tweet.find(params[:id]).user.id
            @tweet = Tweet.find(params[:id])
            if params[:content].empty?
                redirect "/tweets/#{@tweet.id}/edit"
            else
                # binding.pry
                @tweet.update(content: params[:content])
                # binding.pry
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/tweets'
        end
    end
end
