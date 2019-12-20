class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :destroy, :edit, :update, :buy, :pay]
  before_action :get_item, only: [:show, :buy, :pay, :destroy]
  before_action :set_request_from, only: [:buy]
  before_action :set_card, only: [:buy, :pay]

  require 'payjp'

  def index
    @items = Item.last(10)
    delete_session
  end

  def new
    @item = Item.new
    @parent_category = Category.where(ancestry: nil)
  end

  def create
    item = Item.new(item_params)
    # status:1 は"出品中"、出品時は必ず1になる
    item.status = 1
    item.user_id = current_user.id
    #下記の記載は動作確認用のため本実装の際は削除する
    item.grade = 1 # 商品状態
    item.brand_id = 1 # ブランドID
    if item.save
      image_params.to_unsafe_h.reverse_each do |key, value|
        if Itemimage.create(value.merge(item_id: item.id))
          # 出品完了ページがあるのでそちらに飛ぶ
        else
          redirect_to root_path
        end
      end
    else
      redirect_to root_path
    end
  end

  def show
    @images = Itemimage.includes(:item).where(item_id: params[:id])
    @itemimages = Itemimage.includes(:item).first
    @items = Item.where(user_id: @item.user_id).order("rand()").limit(6).where.not(id: @item.id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    redirect_to root_path
  end

  def destroy
    @item.destroy
    if @item.user_id == current_user.id
      redirect_to items_path,notice: '商品を削除しました'
    else
      redirect_to root_path
    end
  end

  def buy
    @image = Itemimage.includes(:item).first
    @address = Address.find_by(user_id: current_user.id) if user_signed_in?
  end

  def pay
    # クレジットカード決済===================================================================
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    if Payjp::Charge.create(
        amount: @item.price,
        customer: @card.customer_id,
        currency: 'jpy'
      )
    else
      # 決済に失敗したらトップページに移動する
      redirect_to root_path
    end
    # クレジットカード決済 ここまで============================================================

    # 商品情報更新(出品状態変更・購入者ID追加)===================================================
    if @item.update(item_buy_params)
      redirect_to checkout_item_path
    else
      redirect_to root_path
    end
    # 商品情報更新 ここまで===================================================================
  end

  def checkout
  end

  def list
    @items = Item.where("status < ?",3)
  end

  private
  def get_item
    @item = Item.find(params[:id])
  end

  def item_buy_params
    # status: 4は”取引中”
    params.permit(:id).merge(buyer_id: current_user.id, status: 4)
  end

  def item_params
    params.require(:item).permit(
      :status,
      :name,
      :from_delivery_area,
      :to_delivery_area,
      :price,
      :delivery_date,
      :size,
      :grade,
      :transfer_fee,
      :delivery_type,
      :describe,
      :buyer_id,
      :user_id,
      :brand_id,
      :category_id
    )
  end

  def image_params
    params.require(:item).require(:images_attributes)
  end

  # ユーザー登録を途中で抜けた場合のsessionを削除
  def delete_session
    session.delete(:nick_name)
    session.delete(:email)
    session.delete(:password)
    session.delete(:last_name)
    session.delete(:first_name)
    session.delete(:last_name_kana)
    session.delete(:first_name_kana)
    session.delete(:birth_year)
    session.delete(:birth_month)
    session.delete(:birth_day)
    session.delete(:pid)
    session.delete(:provider)
    session.delete(:request_from)
  end

  def set_card
    @card = current_user.cards.first
  end

  def set_request_from
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end
end


