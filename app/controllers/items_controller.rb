class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :buy, :pay]
  def index
  end

  def show
    @item = Item.find(params[:id])
    @images = Image.includes(:item)
  end

  def buy
    @item = Item.find(params[:id])
    @image = Image.includes(:item).first
  end

  def pay
    @item.update(item_buy_params)
    redirect_to checkout_item_path
  end

  def done
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
end
