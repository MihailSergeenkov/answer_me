shared_examples_for 'Voted' do
  let(:other_user) { create(:user) }

  describe 'PATCH #vote_up' do
    describe 'other user' do
      it 'save up vote' do
        sign_in(other_user)
        expect { patch :vote_up, id: message, format: :json }.to change(message.votes.votes_up, :count).by(1)
      end
    end

    describe 'owner' do
      it 'save up vote' do
        sign_in(user)
        expect { patch :vote_up, id: message, format: :json }.to_not change(message.votes.votes_up, :count)
      end
    end
  end

  describe 'PATCH #vote_down' do
    describe 'other user' do
      it 'save down vote' do
        sign_in(other_user)
        expect { patch :vote_down, id: message, format: :json }.to change(message.votes.votes_down, :count).by(1)
      end
    end

    describe 'owner' do
      it 'save down vote' do
        sign_in(user)
        expect { patch :vote_down, id: message, format: :json }.to_not change(message.votes.votes_down, :count)
      end
    end
  end

  describe 'DELETE #vote_reset' do
    describe 'other user' do
      it 'reset vote' do
        sign_in(other_user)
        patch :vote_down, id: message, format: :json

        expect { delete :vote_reset, id: message, format: :json }.to change(Vote, :count).by(-1)
      end
    end

    describe 'owner' do
      it 'reset vote' do
        sign_in(user)
        expect { delete :vote_reset, id: message, format: :json }.to_not change(Vote, :count)
      end
    end
  end
end
