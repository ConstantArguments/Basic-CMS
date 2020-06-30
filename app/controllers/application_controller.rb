class ApplicationController < ActionController::Base
  # prevent CSRF, To protect against all other forged requests, we introduce a required security token that our site knows but other sites don't know. We include the security token in requests and verify it on the server.
  protect_from_forgery with: :exception # exception means error

  private # won't be accessible outside of this class unless inherited (most inherit from this)

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      # for security redirect prevents requested action from running
      redirect_to(access_login_path)
    end
  end

end
