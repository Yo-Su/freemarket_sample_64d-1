require 'rails_helper'

describe ItemsController, type: :controller do

  describe 'DELITE #destroy' do
    it "期待するビューに遷移するか？" do
      get :index
      expect(response).to render_template :index
    end
  end
end
