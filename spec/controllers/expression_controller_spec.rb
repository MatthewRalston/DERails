require 'rails_helper'

RSpec.describe ExpressionController, :type => :controller do

  describe "GET maplot" do
    it "returns http success" do
      get :maplot
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET correlation" do
    it "returns http success" do
      get :correlation
      expect(response).to have_http_status(:success)
    end
  end

end
