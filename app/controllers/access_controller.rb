class AccessController < ApplicationController

  layout 'admin'

  # except whitlists in case I add other actions, still secure
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def menu
    # display text and links
    @username = session[:username]
  end

  def login
    # display login form
  end

  def attempt_login
    # are both fields filled out?
    if params[:username].present? && params[:password].present?
      # sanitize input with which and query db
     found_user = AdminUser.where(:username => params[:username]).first
     if found_user
      # check password
      authorized_user = found_user.authenticate(params[:password])
     end
    end

    if authorized_user
      # good password
      session[:user_id] = authorized_user.id # cache in session
      session[:username] = authorized_user.username # cache in session
      flash[:notice] = "You are now logged in."
      redirect_to(admin_path)
    else
      # bad password, but dont tell them which is bad
      # flash notice now on current request insted of next page
      flash.now[:notice] = "Invalid username/password combination."
      render('login')
    end

  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You are logged out"
    redirect_to(access_login_path)
  end

end
