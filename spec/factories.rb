FactoryGirl.define do
  factory :survey do
    name 'Salesforce 101 Knowledge Test'
    description 'Are you ready?'    
  end

  factory :question do
    title 'What are the differences between Lookup relationship and Master-Detail relationship?'
    score 2
  end
end