module UserSessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token  = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token);
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or(options = {}, response_status = {})
    if session[:return_to]
      redirect_to session[:return_to]
    else
      redirect_to options, response_status
    end
    session.delete(:return_to)
  end
end
