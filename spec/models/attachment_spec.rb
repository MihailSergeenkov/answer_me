require 'rails_helper'

RSpec.describe Attachment, type: :model do
  context 'Validates file' do
    it { should validate_presence_of :file }
  end

  context 'Validates association with question or answer' do
    it { should belong_to :attachable }
  end
end
