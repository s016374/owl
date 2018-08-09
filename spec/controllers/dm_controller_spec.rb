require 'rails_helper'

RSpec.describe DmController, type: :controller do

  describe "GET #svn_merge" do
    it "returns http success" do
      get :svn_merge
      expect(response).to have_http_status(:success)
    end
  end

end
