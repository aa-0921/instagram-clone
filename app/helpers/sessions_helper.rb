module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember # 引数なしのrememberはRandom new_tokenを保存する
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  @current_userを返す為のメソッド
  def current_user
    if (user_id = session[:user_id]) #ユーザーIDでのセッションが存在すれば
      @current_user ||= User.find_by(id:user_id]) 
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      ユーザーが存在してかつ、トークンでの認証が成功すれば
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

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
