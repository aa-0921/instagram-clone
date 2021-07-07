require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  # 2つのバグのテスト2
  describe "authenticated? should return false for a user with nil digest" do
    # ダイジェストが存在しない場合のauthenticated?のテスト
    it "is invalid without remember_digest" do
      expect(user.authenticated?(:remember_token)).to eq false
    end
  end
end
