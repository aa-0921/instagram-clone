require 'rails_helper'

RSpec.feature "Login", type: :feature, js: true do
  let(:user) { FactoryBot.create(:user) }

  # ログインに成功すること
  scenario "user successfully login" do
    valid_login(user)

    expect(current_path).to eq user_path(user)
    expect(page).not_to have_content "ログインする"
  end

  # 無効な情報ではログインに失敗すること
  scenario "user doesn't login with invalid information" do
    visit root_path
    click_link "Log in"
    fill_in "session[email]", with: ""
    fill_in "session[password]", with: ""
    click_button "Log in"

    expect(current_path).to eq login_path
    expect(page).to have_content "Log in"
    expect(page).to have_content "Invalid email/password combination"
  end
end
