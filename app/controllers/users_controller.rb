class UsersController < ApplicationController

    get '/signup' do
        # binding.pry
        if session[:user_id]
            redirect '/tweets'
        else
            erb :"users/create_user"
        end
    end

    post '/signup' do
        # binding.pry
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect '/signup'
        else
            @user = User.create(params)
            # binding.pry
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        binding.pry
        if session[:user_id]
            redirect '/tweets'
        else
            erb :"users/login"
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
        
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end
