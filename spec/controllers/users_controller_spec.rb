require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :users
      expect(response).to have_http_status(:success)
    end
  end
end
