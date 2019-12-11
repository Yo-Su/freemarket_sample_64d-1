class SellController < ApplicationController
  before_action :create_items_instance, only:[:index,:destroy]

  def index
    
  end
end


private
def create_items_instance
  @item = Item.new
end