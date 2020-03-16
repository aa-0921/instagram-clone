require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe "Home page" do
    before do
      visit static_pages_home_path
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

  describe 'Home' do
    specify '画面の表示' do
      visit '/static_pages/home'
      expect(page).to have_css('h1', text: 'Instagram-clone')
    end
  end

  describe 'Help' do
    specify '画面の表示' do
      visit '/static_pages/help'
      expect(page).to have_css('h1', text: 'Help')
    end
  end

  describe 'about' do
    specify '画面の表示' do
      visit '/static_pages/about'
      expect(page).to have_css('h1', text: 'About')
    end
  end
end
