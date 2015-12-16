shared_examples_for 'Commentable' do
  context 'Validates association with commment' do
    it { should have_many(:comments).dependent :destroy }
  end
end
