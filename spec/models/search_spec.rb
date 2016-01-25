require 'rails_helper'

RSpec.describe Search, type: :model do
  let(:question) { create(:question) }

  describe '.query' do
    it 'should give array of questions' do
      expect(ThinkingSphinx).to receive(:search).with(question.title.slice(0..1), classes: [Question])
      Search.query(question.title.slice(0..1), 'Questions')
    end
  end
end
