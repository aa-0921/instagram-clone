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
end
