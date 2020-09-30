require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
  

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def redirect_if_not_logged_in
    if !current_user
      redirect "/login"
    end
  end

end
