class CategoriesController < ApplicationController

  def set_children_category
    @category = Category.where(ancestry: params[:parent_id].to_i)
  end

  def set_grandchild_category
    @category = Category.where(ancestry: params[:children_id].to_i)
  end

end
