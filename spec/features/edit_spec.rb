# require 'rails_helper'

# RSpec.feature "Edit", type: :feature, js: true do
#   before do
#     @user = FactoryBot.create(:user)
#     @another_user = FactoryBot.create(:another_user)
#   end

#   describe "#edit" do
#     context "as an authorized user" do
#       # 正常なレスポンスか？
#       it "responds successfully" do
#         signup_url @user
#         get :edit, params: { id: @user.id }
#         expect(response).to be_success
#       end
#       # 200レスポンスが返ってきているか？
#       it "returns a 200 response" do
#         sign_in @user
#         get :edit, params: { id: @user.id }
#         expect(response).to have_http_status "200"
#       end
#     end

#     context "as an unauthorized user" do
#       # 正常なレスポンスが返ってきていないか？
#       it "does not respond successfully" do
#         sign_in @another_user
#         get :edit, params: { id: @user.id }
#         expect(response).not_to be_success
#       end
#       # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
#       it "redirects the page to root_path" do
#         sign_in @another_user
#         get :edit, params: { id: @user.id }
#         expect(response).to redirect_to root_path
#       end
#     end

#     context "as a guest user" do
#       # 302レスポンスが返ってきているか？
#       it "returns a 302 response" do
#         get :edit, params: { id: @user.id }
#         expect(response).to have_http_status "302"
#       end
#       # ログイン画面にリダイレクトされているか？
#       it "redirects the page to /users/sign_in" do
#         get :edit, params: { id: @user.id }
#         expect(response).to redirect_to "/users/sign_in"
#       end
#     end
#   end
# end
