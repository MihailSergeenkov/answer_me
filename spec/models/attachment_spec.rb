require 'rails_helper'

RSpec.describe Attachment, type: :model do
  context 'Validates association with question or answer' do
    it { should belong_to :attachable }
  end
end
