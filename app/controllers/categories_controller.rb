class CategoriesController < ApplicationController

  def set_children_category
    @children_category = Category.where(ancestry: params[:parent_id].to_i)
  end

  def set_grandchild_category
    @grandchild_category = Category.find("#{params[:children_id]}").children
  end

end
