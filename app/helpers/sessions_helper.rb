module SessionsHelper
  # helper_method :resource_name, :resource, :devise_mapping, :resource_class

  # def resource_name
  #   :user
  # end

  # def resource
  #   @resource ||= User.new
  # end

  # def resource_class
  #   User
  # end

  # def devise_mapping
  #   @devise_mapping ||= Devise.mappings[:user]
  # end

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember # 引数なしのrememberはRandom new_tokenを保存する
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user?(user)
    user == current_user
  end

  # @current_userを返す為のメソッド
  def current_user
    if (user_id = session[:user_id]) # ユーザーIDでのセッションが存在すれば
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # ユーザーが存在してかつ、トークンでの認証が成功すれば
      if user && user.authneticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    # !否定演算子でcurrent_userが空でないならtrue
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したurlにリダイレクト（それがない場合はデフォルトのルート）
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # リクエストがあった場合は、元々表示しようとしていたページのパスをセッションに保存。
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
