require 'rails_helper'

describe QuestionsController do
  let(:other_user) { create(:user) }
  let(:user) { create(:user) }
  let(:post) { create(:question, user: user) }

  it_behaves_like 'Voted'
end

describe AnswersController do
  let(:other_user) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:post) { create(:answer, user: user) }

  it_behaves_like 'Voted'
end
