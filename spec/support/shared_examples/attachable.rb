shared_examples_for 'Attachable' do
  context 'Validates association with attachment' do
    it { should have_many(:attachments).dependent :destroy }
  end

  context 'Accept nested attributes for attachments' do
    it { should accept_nested_attributes_for :attachments }
  end
end
