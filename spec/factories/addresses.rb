FactoryBot.define do

  factory :address do
    last_name             {"山田"}
    first_name            {"太郎"}
    last_name_kana        {"ヤマダ"}
    first_name_kana       {"タロウ"}
    post_number           {"123"}
    prefecture            {"東京"}
    municipality          {"渋谷区"}
    block                 {"1-1-1"}
  end

end