class SellController < ApplicationController
  before_action :create_items_instance, only:[:index, :new,:show,:destroy]

  def index
    
  end

  def new
    @item_image = @item.images.build
  end
end


private
def create_items_instance
  @item = Item.new
end