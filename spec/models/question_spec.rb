require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:post) { create(:question, user: user) }

  it_behaves_like 'Votable'
  it_behaves_like 'Attachable'
  it_behaves_like 'Commentable'

  context 'Validates title question' do
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_most 100 }
  end

  context 'Validates user_id in question' do
    it { should validate_presence_of :user_id }
  end

  context 'Validates body question' do
    it { should validate_presence_of :body }
  end

  context 'Validates association with answers' do
    it { should have_many(:answers).dependent :destroy }
  end

  context 'Validates association with user' do
    it { should belong_to :user }
  end
end
