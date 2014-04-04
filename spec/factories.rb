FactoryGirl.define do
  factory :valid_user, class: User do
    name                  'mokoaki'
    email                 'mokoriso@gmail.com'
    password              'mokoaki'
    password_confirmation 'mokoaki'
  end
end
