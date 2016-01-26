require 'rails_helper'

RSpec.describe Search, type: :model do
  describe '.query' do
    %w(Questions Answers Comments Users).each do |object|
      it "should give array of #{object}" do
        expect(ThinkingSphinx).to receive(:search).with('My', classes: [object.singularize.classify.constantize])
        Search.query('My', "#{object}")
      end
    end

    it "should give array of Anything object" do
      expect(ThinkingSphinx).to receive(:search).with('My')
      Search.query('My', 'Anything')
    end

    it "invalid condition should give empty array" do
      result = Search.query('My', 'ErrorObject')
      expect(result).to eql []
    end
  end
end
