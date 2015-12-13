require 'rails_helper'

describe Question do
  let(:other_user) { create(:user) }
  let(:user) { create(:user) }
  let(:post) { create(:question, user: user) }
  
  it_behaves_like 'Votable'
end

describe Answer do
  let(:other_user) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:post) { create(:answer, user: user) }

  it_behaves_like 'Votable'
end
