require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'Validates body answer' do
    it { should validate_presence_of :body }
  end

  context 'Validates user_id in answer' do
    it { should validate_presence_of :user_id }
  end

  context 'Validates association with question' do
    it { should belong_to :question }
    it { should validate_presence_of :question_id }
  end

  context 'Validates association with user' do
    it { should belong_to :user }
  end

  describe '#make_best' do
    let(:answer) { create(:answer) }
    let(:answers) { create_list(:answer, 3) }

    it 'make best answer' do
      answer.make_best
      expect(answer.best).to eq true
    end

    it 'make best another answer' do
      answers.first.make_best
      answers.last.make_best
      answers[0..-2].each do
        expect(answer.best).to eq false
      end
    end
  end

  context 'Validates association with attachment' do
    it { should have_many :attachments }
  end

  context 'Accept nested attributes for attachments' do
    it { should accept_nested_attributes_for :attachments }
  end
end
