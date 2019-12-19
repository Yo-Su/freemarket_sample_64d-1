module CardsHelper
  def card_logo(card)
    case card.brand
    when "Visa"
      image_tag "//www-mercari-jp.akamaized.net/assets/img/card/visa.svg?82960919", size: "49x20",alt:"visa"
    when "MasterCard"
      image_tag "//www-mercari-jp.akamaized.net/assets/img/card/master-card.svg?82960919", size: "34x20",alt:"master"
    when "JCB"
      image_tag "//www-mercari-jp.akamaized.net/assets/img/card/jcb.svg?1215422380", size: "30x20",alt:"jcb"
    when "American Express"
      image_tag "//www-mercari-jp.akamaized.net/assets/img/card/american_express.svg?1215422380", size: "21x20",alt:"american"
    when "Diners Club"
      image_tag "//www-mercari-jp.akamaized.net/assets/img/card/dinersclub.svg?82960919", size: "32x20",alt:"dinersclub"
    when "Discover"
      image_tag "//www-mercari-jp.akamaized.net/assets/img/card/discover.svg?82960919", size: "32x20",alt:"discover"
    end
  end

  def card_number(card)
    case card.brand
    when "Visa", "MasterCard", "JCB", "Discover"
      "************#{sprintf("%04d", card.card_number)}"
    when "American Express"
      "***********#{sprintf("%04d", card.card_number)}"
    when "Diners Club"
      "**********#{sprintf("%04d", card.card_number)}"
    end
  end
end
