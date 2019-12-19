FactoryBot.define do

  factory :user do
    nick_name              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    last_name             {"山田"}
    first_name            {"太郎"}
    last_name_kana        {"ヤマダ"}
    first_name_kana       {"タロウ"}
    birthday             {"2019-12-03"}
    phone_number          {"09011112222"}
  end

end

