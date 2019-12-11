class ItemsController < ApplicationController
  def index
  end

  def new
    @item=Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  private
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


