class CardsController < ApplicationController
  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

  def index
  end

  def new
  end

  def destroy
  end

  def create
    token = Payjp::Token.create({
      card: {
        number:      params[:card_number],
        cvc:         params[:pin_number],
        exp_month:   params[:exp_month],
        exp_year:    "20" + params[:exp_year]
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'}
    )
    card = Payjp::Customer.create(card: token.id)
    credit_card = Card.new(
      card_number: card.cards.data[0].last4,
      brand:       card.cards.data[0].brand,
      exp_month:   card.cards.data[0].exp_month,
      exp_year:    card.cards.data[0].exp_year,
      user_id:     1 # current_user.id
    )
    if credit_card.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
