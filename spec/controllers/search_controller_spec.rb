require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    let(:question) { create(:question) }

    it 'should give array of question' do
      expect(ThinkingSphinx).to receive(:search).with(question.title.slice(0..1), classes: [Question])
      get :search, query: question.title.slice(0..1), condition: 'Questions'
    end
  end
end
