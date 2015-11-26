FactoryGirl.define do
  sequence :title do |n|
    "My Question #{n.ordinalize} Title"
  end

  factory :question do
    title
    body
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user
  end
end
