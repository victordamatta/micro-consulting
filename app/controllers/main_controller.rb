class MainController < ApplicationController
  
  def intro
  end

  def login_page
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to questions_path
    else
      flash.now.alert = "Email ou senha incorreta"
      render 'login_page'
    end
  end

  def logout
    log_out
    redirect_to root_url
  end
end
