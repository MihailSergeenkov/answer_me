require 'rails_helper'

RSpec.describe Vote do
  context 'Validates user_id in vote' do
    it { should validate_presence_of :user_id }
    it { should belong_to :user }
  end

  context 'Validates association with question or answer' do
    it { should belong_to :votable }
  end

  context 'Validates value' do
    it { should validate_inclusion_of(:value).in_array([1, -1]) }
  end
end
