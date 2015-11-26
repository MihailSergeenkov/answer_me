FactoryGirl.define do
  sequence :body do |n|
    "My Body #{n.ordinalize}"
  end
end
