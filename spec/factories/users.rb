FactoryBot.define do
  factory :user do
    nickname              {"testkun"}
    email                 {Faker::Internet.email}
    password              {"test1234"}
    password_confirmation {password}
    family_name {"山田"}
    first_name {"太郎"}
    family_name_kana{"カタカナ"}
    first_name_kana{"カタカナ"}
    birth_day{"2000-01-01"}
  end
end