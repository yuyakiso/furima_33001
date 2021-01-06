FactoryBot.define do
  factory :order_form do
    postal_code   {"000-0000"}
    prefecture_id {1}
    city          {"テスト市"}
    address       {"テスト町0-0-0"}
    phone_number  {"00000000000"}
    token {"tok_abcdefghijk00000000000000000"}
  end
end