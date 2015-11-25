FactoryGirl.define do
  sequence :title do |n|
    "My Question #{n.ordinalize} Title"
  end

  sequence :question_body do |n|
    "My Question #{n.ordinalize} Body"
  end

  factory :question do
    title
    body { generate(:question_body) }
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user
  end
end
