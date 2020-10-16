class UsersController < ApplicationController

    get '/' do 
       redirect '/login'
    end 
    
    get '/signup' do 
        if current_user
            redirect '/reservations'
        else
            #@user = User.new 
            erb :'/users/signup'
        end 
    end 

    post '/signup' do  
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id 
            redirect '/reservations'
        else
            @errors = @user.errors.full_messages
            erb :'/users/signup'
        end
    end 

    get '/login' do 
        if current_user
            redirect '/reservations'
        else
            @user = User.new 
            erb :'/users/login'
        end 
    end 

    post '/login' do 
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id 
            redirect '/reservations'
        else
            @user = User.new(params[:user])
            @errors = ["Invalid Email or Password"]
            erb :'/users/login'
        end 
    end 

    delete '/logout' do 
        session[:user_id] = nil 
        redirect '/login'
    end 
end 