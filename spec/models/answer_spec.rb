require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'Validates body answer' do
    it { should validate_presence_of :body }
  end

  context 'Validates association with question' do
    it { should belong_to :question }
    it { should validate_presence_of :question_id }
  end
end
