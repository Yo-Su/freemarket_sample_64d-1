require 'rails_helper'

describe SignupController, type: :controller do

  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #member_info' do
    it "assigns the requested user to @user" do
      session[:nick_name] = "ドラえもん"
      session[:email] = "example@gmail.com"
      session[:password] = "example1"
      get :member_info
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :member_info template" do
      get :member_info
      expect(response).to render_template :member_info
    end
  end

  describe 'GET #phone_info' do
    let(:params) { { user: attributes_for(:user) } }
    it "assigns the requested user to @user" do
      get :phone_info, params: params
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :phone_info template" do
      get :phone_info
      expect(response).to render_template :phone_info
    end
  end

  describe 'GET #sms_confirmation' do
    let(:params) { { user: attributes_for(:user) } }
    it "assigns the requested user to @user" do
      get :sms_confirmation, params: params
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :sms_confirmation template" do
      get :sms_confirmation
      expect(response).to render_template :sms_confirmation
    end
  end

  describe 'POST #create' do
    let(:params) { { user: attributes_for(:user) } }
    before do
      session[:nick_name] = "abe"
      session[:email] = "kkk@gmail.com"
      session[:password] = "00000000"
      session[:last_name] = "山田"
      session[:first_name] = "太郎"
      session[:last_name_kana] = "ヤマダ"
      session[:first_name_kana] = "タロウ"
      session[:phone_number] = "09011112222"
      session[:birth_year] = "2019"
      session[:birth_month] = "12"
      session[:birth_day] = "03"
      session[:uid] = 1
      session[:provider] = "a"
    end
    it "count up user" do
      expect{post :create, params: params}.to change(User, :count).by(1)
    end
    it "redirects to address_info_signup_index_path" do
      post :create, params: params
      expect(response).to redirect_to(address_info_signup_index_path)
    end
  end

  describe 'GET #address_info' do
    let(:user) { create(:user) }
    let(:params) { { user_id: user.id, address: attributes_for(:address) } }
    before do
      login user
    end
    describe 'log in' do
      it "assigns the requested address to @address" do
        get :address_info, params: params
        expect(assigns(:address)).to be_a_new(Address)
      end
    end
    it "renders the :complete template" do
      get :address_info
      expect(response).to render_template :address_info
    end
  end

  describe 'GET #credit_info' do
    let(:user) { create(:user) }
    let(:params) { { user_id: user.id, address: attributes_for(:address) } }
    before do
      login user
    end
    describe 'log in' do
      it "assigns the requested address to @address" do
        address = create(:address, user_id: user.id)
        get :credit_info, params: params
        expect(assigns(:address)).to eq address
      end
    end
    it "redirects to new_card_path" do
      get :credit_info, params: params
      expect(response).to redirect_to(new_card_path)
    end
  end

  describe 'GET #complete' do
    it "renders the :complete template" do
      get :complete
      expect(response).to render_template :complete
    end
  end

end