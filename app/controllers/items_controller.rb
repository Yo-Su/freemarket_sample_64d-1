class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :destroy, :edit, :update, :buy, :pay]
  before_action :get_item, only: [:show, :buy, :pay, :destroy, :edit, :update]
  before_action :set_request_from, only: [:buy]
  before_action :set_card, only: [:buy, :pay]

  require 'payjp'

  def index
    @ladies_items = Item.where(category: 160..339).last(10)
    @mens_items = Item.where(category: 340..470).last(10)
    @electronics_items = Item.where(category: 955..1029).last(10)
    @toys_items = Item.where(category: 766..866).last(10)
    delete_session
  end

  def new
    @item = Item.new
    @parent_category = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    # status:1 は"出品中"、出品時は必ず1になる
    @item.status = 1
    @item.user_id = current_user.id
    # brandは未定義のため、一旦固定値
    @item.brand_id = 1 # ブランドID
    if @item.save
      image_params.to_unsafe_h.reverse_each do |key, value|
        image = Itemimage.new(value.merge(item_id: @item.id))
        if image.save
          # 出品完了ページがあるのでそちらに飛ぶ
        else
          @item.destroy
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
    @parent_category = @item.category.root
    grandchild_category_first_id = Category.indirects_of(@parent_category).first.id
    grandchild_category_last_id  = Category.indirects_of(@parent_category).last.id
    @category_items = Item.where(category_id: grandchild_category_first_id..grandchild_category_last_id).order("rand()").limit(6).where.not(id: @item.id)
  end

  def edit
    @parent_category        = Category.where(ancestry: nil)
    @children_category      = @item.category.parent.parent.children
    @grandchildren_category = @item.category.parent.children
  end

  def update
    @item_images = @item.itemimages
    item_image_count = @item_images.count

    # 商品編集により画像が0以下になる場合、編集ページに戻る
    if item_image_count + count_add_item_image - count_delete_item_image <= 0
      redirect_to edit_item_path(@item.id)
    else
      if @item.update(item_params)
        # 削除する画像がある場合、その画像を削除する
        if choose_item_image_destroy
          choose_item_image_destroy.each_with_index do |item_image, index|
            @item_images[index].destroy if item_image == 0
          end
        end
        # 新しく追加された画像がある場合、その画像を保存する
        if image_params
          image_params.to_unsafe_h.reverse_each do |key, value|
            # 保存に失敗する、画像の保存に失敗したらトップページに移動
            redirect_to root_path unless Itemimage.create(value.merge(item_id: @item.id))
          end
        end
        # 全部完了したら商品詳細ページに移動
        redirect_to item_path(@item.id)
      else
        # 商品の更新に失敗したらトップページに移動
        redirect_to root_path
      end
    end
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
    @image = @item.itemimages.first
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
    @items = Item.where("status < ?",3).limit(50).where(user_id: current_user)
  end

  def search
    @items = Item.search(params[:keyword])
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
    params.require(:item).require(:images_attributes) if params.require(:item)[:images_attributes]
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

  def choose_item_image_destroy
    params.require(:"item-image-array").split("").map{|item| item.to_i} if params[:"item-image-array"]
  end

  # 商品編集で追加する画像数
  def count_add_item_image
    params.require(:item)[:images_attributes] ? image_params.to_unsafe_h.length : 0
  end

  # 商品編集で削除する画像数
  def count_delete_item_image
    params[:"item-image-array"] ? choose_item_image_destroy.count(0) : 0
  end
end


