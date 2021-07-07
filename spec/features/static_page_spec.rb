require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe "Home page" do
    before do
      visit root_path
    end

    # HomeページにInstagram-cloneと表示されていること
    it "has the content 'Instagram-clone'" do
      expect(page).to have_content "Instagram-clone"
    end

    # タイトルが正しく表示されていること
    it "has the right title" do
      expect(page).to have_title full_title('')
    end
  end

  feature "UserPages", type: :feature do
    describe "signup page" do
      before do
        visit signup_path
      end

      # 新規登録ページに”Sign up"と表示されている事"
      it "has the content 'Sign up'" do
        expect(page).to have_content "Sign up"
      end

      # タイトルが正しく表示されている事
      it "has the right title" do
        expect(page).to have_title full_title('Sign up')
      end
    end
  end

  describe 'Home' do
    specify '画面の表示' do
      visit root_path
      expect(page).to have_css('h2', text: 'Instagram-clone')
    end
  end

  describe 'Help' do
    specify '画面の表示' do
      visit help_path
      expect(page).to have_css('h1', text: 'Help')
    end
  end

  describe 'about' do
    specify '画面の表示' do
      visit about_path
      expect(page).to have_css('h1', text: 'About')
    end
  end
end
