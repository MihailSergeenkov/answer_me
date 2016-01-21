require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:post) { create(:question, user: user) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  it_behaves_like 'Votable'
  it_behaves_like 'Attachable'
  it_behaves_like 'Commentable'
  it_behaves_like 'Userable'

  context 'Validates title question' do
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_most 100 }
  end

  context 'Validates body question' do
    it { should validate_presence_of :body }
  end

  context 'Validates association with answers' do
    it { should have_many(:answers).dependent :destroy }
  end

  describe '#subscribe' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    context 'not subscribed' do
      it 'should create subscription' do
        expect { question.subscribe(user) }.to change(question.subscriptions, :count).by(1)
      end
    end

    context 'subscribed' do
      let!(:subscription) { create(:subscription, user: user, question: question) }

      it 'subscription already create' do
        expect { question.subscribe(user) }.to_not change(question.subscriptions, :count)
      end
    end
  end

  describe '#unsubscribe' do
    let!(:user) { create(:user) }
    let(:question) { create(:question) }
    let!(:subscription) { create(:subscription, user: user, question: question) }

    it 'should unsubscribe' do
      expect { question.unsubscribe(user) }.to change(question.subscriptions, :count).by(-1)
    end
  end
end
