shared_examples_for 'Votable' do
  context 'Validates association with votes' do
    it { should have_many(:votes).dependent :destroy }
  end

  describe '#vote' do
    it 'vote up for post' do
      post.vote(other_user, 1)
      expect(post.votes.votes_up.count).to eq 1
    end

    it 'vote down for post' do
      post.vote(other_user, -1)
      expect(post.votes.votes_down.count).to eq 1
    end
  end

  describe '#vote_reset' do
    it 'reset vote for post' do
      post.vote(other_user, 1)
      post.vote_reset(other_user)
      expect(post.votes.votes_up.count).to eq 0
    end
  end
end
