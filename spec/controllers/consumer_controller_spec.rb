require 'rails_helper'

RSpec.describe ConsumerController, type: :controller do

  describe "GET #foo" do
    it "returns http success" do
      get :foo
      expect(response).to have_http_status(:success)
    end
  end

end
