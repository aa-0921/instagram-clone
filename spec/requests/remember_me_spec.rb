require 'rails_helper'

RSpec.describe "Remember me", type: :request do
  let(:user) { FactoryBot.create(:user) }

  # 2つのバグのテスト1
  context "with valid information" do
    # ログイン中のみログアウトすること
    it "logs in with valid information followed by logout" do
      sign_in_as(user) # spec/support/utilities.rbに定義
      expect(response).to redirect_to user_path(user)

      # ログアウトする
      get logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil

      # 2番目のウィンドウでログアウトする
      get logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
    end
  end

  # remember_meチェックボックスのテスト
  context "login with remembering" do
    it "remembers cookies" do
      post login_path, params: { session: {
        email: user.email,
        password: user.password,
        remember_me: '1',
      } }
      expect(response.cookies['remember_token']).not_to eq nil
    end
  end

  # context "login without remembering" do
  #   it "doesn't remember cookies" do
  #     # クッキーを保存してログイン
  #     post login_path, params: { session: {
  #       email: user.email,
  #       password: user.password,
  #       remember_me: '1',
  #     } }
  #     get logout_path
  #     # クッキーを保存せずにログイン
  #     post login_path, params: { session: {
  #       email: user.email,
  #       password: user.password,
  #       remember_me: '0',
  #     } }
  #     expect(response.cookies['remember_token']).to eq nil
  #   end
  # end
end
