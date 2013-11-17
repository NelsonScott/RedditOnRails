module SessionsHelper
  def login_user!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def current_user
    return nil if session[:token].nil?
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def authenticate_user!
    unless current_user
      redirect_to new_session_url
    end
  end

  def new_user?
    redirect_to current_user if current_user
  end
end