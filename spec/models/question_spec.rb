require 'rails_helper'

RSpec.describe Question, type: :model do
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

  context 'Validates association with attachment' do
    it { should have_many :attachments }
  end

  context 'Accept nested attributes for attachments' do
    it { should accept_nested_attributes_for :attachments }
  end
end
