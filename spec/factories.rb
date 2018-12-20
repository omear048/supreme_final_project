FactoryGirl.define do
  factory :user do 
    name { "Person #{User.count + 1}" }
    # sequence(:name) { |n| "Person #{n}"}
    # sequence(:email){ |n| "Person_#{n}@gmail.com"}
    email { "Person_#{User.count + 1}@gmail.com"}
    password "password"
    password_confirmation "password"
  end

  factory :product do #[pg. 519]
    title "Supreme Box Logo Hoodie"
    price 1500
    picture_url "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTZDvHJjscJNpCmiKKDZ_NnvSyYfzLZNwjS1_7sp8Kx8fuKWj1Tj8hlEiPyocsUqrH6F9rRkJU&usqp=CAE"
    user
  end

  factory :products_user do 
  end

  factory :users_address do
    name "Kris OMeara"
    address "2101 Market Street"
    city "Denver"
    state "CO"
    zip 80205
  end

  factory :order do 
  end

  factory :items_order do 
  end

end