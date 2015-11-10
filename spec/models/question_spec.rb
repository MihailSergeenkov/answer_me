require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'Validates title question' do
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_most(100) }
  end

  context 'Validates body question' do
    it { should validate_presence_of :body }
  end

#  it 'validates presence of title' do
#    expect(Question.new(body: "I don't know")).to_not be_valid
#  end
#
#  it 'validates presence of body' do
#    expect(Question.new(title: 'Help me!')).to_not be_valid
#  end
end
