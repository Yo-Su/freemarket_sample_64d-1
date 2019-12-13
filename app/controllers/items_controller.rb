class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new,:create,:destroy,:edit,:update]
  before_action :get_item, only: [:show, :buy, :pay]
  def index
  end

  def new
    @item=Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    else
      redirect_to root_path   
    end
  end

  def show
    @images = Image.includes(:item)
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  def buy
    @image = Image.includes(:item).first
  end

  def pay
    if @item.update(item_buy_params)
      redirect_to checkout_item_path
    else
      redirect_to root_path
    end
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
    
end


