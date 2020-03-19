module LoginSupport
  def valid_login(user)
    visit root_path

    click_link "Log in"
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    take_screenshot
    click_button "Log in"
  end
end

# 上のLoginSupportモジュールをincludeしてconfigに書きこむ
RSpec.configure do |config|
  config.include LoginSupport
end
