FactoryBot.define do

  factory :item do
    user_id               {"1"}
    status                {"1"}
    name                  {"テストのヒト"}
    from_delivery_area    {"1"}
    to_delivery_area      {"1"}
    price                 {"1000"}
    delivery_date         {"1"}
    size                  {"1"}
    grade                 {"1"}
    transfer_fee          {"1"}
    delivery_type         {"1"}
    describe              {"1"}
    buyer_id              {"1"}
    user_id               {"1"}
    brand_id              {"1"}
    itemimages {[
      FactoryBot.build(:itemimage, item: nil)  #itemと同時にimage作成
    ]}
  end
end