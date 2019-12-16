class ItemsController < ApplicationController
  # before_action :authenticate_user!, only:[:new,:create,:destroy,:edit,:update]
  before_action :get_item, only: [:show, :buy, :pay, :destroy]
  
  require 'payjp'
  
  def index
  end

  def new
    @item=Item.new
  end

  def create
    image = Itemimage.new(image_params)
    item = Item.new(item_params)
    #下記の記載は動作確認用のため本実装の際は削除する
    item.status = 1
    item.grade = 1
    item.user_id = 1
    item.brand_id = 1
    item.category_id = 1

    if item.save
      image.item_id = item.id
      if image.save
        # 出品完了ページがあるのでそちらに飛ぶ
      end
    else
      redirect_to root_path   
    end
  end

  def show
    @images = Itemimage.includes(:item).where(item_id: params[:id])
  end

  def edit
  end

  def update
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
    @image = Image.includes(:item).first
    # ログインしているユーザーのカード情報を取得(ログイン機能が実装されていないため暫定で１を代入)
    @card = Card.find_by(user_id: 1)
  end

  def pay
    # クレジットカード決済===================================================================
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    # ログインしているユーザーのカード情報を取得(ログイン機能が実装されていないため暫定で１を代入)
    card = Card.where(user_id: 1).first
    if Payjp::Charge.create(
        amount: @item.price,
        customer: card.customer_id,
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


  private
  def get_item
    @item = Item.find(params[:id])
  end

  def item_buy_params
    # current_user.idの代わり、ログイン機能実装後に入れ替える
    test_id = 2
    params.permit(:id).merge(buyer_id: test_id, status: "購入中")
  end

  def item_params
    params.require(:item).permit(
      :status,
      :name,
      :from_delivery_area,
      :to_delivery_area,
      :price,
      :delivery_date,
      :size,:grade,
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
    params.require(:item).permit(:image).merge(item_id: 1)
  end
end


