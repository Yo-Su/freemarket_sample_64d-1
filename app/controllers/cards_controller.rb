class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request_from, only: [:index]
  before_action :set_card, only: [:index, :destroy]

  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

  def index
  end

  def new
  end

  def create
    token = Payjp::Token.create({
      card: {
        number:      params[:card_number],
        cvc:         params[:pin_number],
        exp_month:   params[:exp_month],
        exp_year:    '20' + params[:exp_year]
        }},
        {'X-Payjp-Direct-Token-Generate': 'true'}
      )
    card = Payjp::Customer.create(card: token.id)
    credit_card = Card.new(
      card_number: card.cards.data[0].last4,
      brand:       card.cards.data[0].brand,
      exp_month:   card.cards.data[0].exp_month,
      exp_year:    card.cards.data[0].exp_year,
      user_id:     current_user.id,
      customer_id: card.cards.data[0].customer,
      card_id:     card.cards.data[0].id
    )
    request_from = session[:request_from]
    session.delete(:request_from)
    if credit_card.save
      redirect_to request_from ? request_from : complete_signup_index_path
    else
      redirect_to root_path
    end
  end

  def destroy
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      if customer.delete && @card.delete
        redirect_to cards_path
      else
        redirect_to root_path
      end
    end
  end

  private

    def set_card
      @card = current_user.cards.first
    end

    def set_request_from
      # 現在のURLを保存しておく
      session[:request_from] = request.original_url
    end

end
