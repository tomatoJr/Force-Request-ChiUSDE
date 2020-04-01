# This will guess the User class
FactoryGirl.define do
  factory :student_request do
    name "John Doe"
    uin "345345345"
    major "CSCE"
    classification "G8"
    email "johndoe@tamu.edu"
    request_semester "2020 Spring"
    course_id "633"
    priority "High"
    phone "9793459799"
    section_id "505"
    state "Withdraw"
  end
  
  factory :limit do
    classification "G8"
    High 5
  end

  factory :student do
    name "John Doe"
    email "johndoe@tamu.edu"
    password "DarthVader123"
    uin "12345678"
  end

  factory :admin do
    name "Schaeffer"
    uin "12345678"
    password "SchaefferDoesntKnow"
    email "IAmSchaeffer@tamu.edu"
  end
end
