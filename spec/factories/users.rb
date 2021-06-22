FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    transient do
      person {Gimei.name}
    end
    birthday { Faker::Date.backward }
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_reading { person.first.katakana }
    last_name_reading { person.last.katakana }
  end
end