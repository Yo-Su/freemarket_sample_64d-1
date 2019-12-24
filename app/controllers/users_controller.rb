class UsersController < ApplicationController
  before_action :set_request_from, only: [:show]

  def show
  end

  def edit
  end

  def update
  end

  private
  def set_request_from
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end
end
