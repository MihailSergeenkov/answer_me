require 'rails_helper'

RSpec.describe NotificationQuestionSubscribersJob, type: :job do
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question) }
  let!(:subscription) { create(:subscription, question: question) }

  it 'sends notification for question subscribers' do
    question.subscriptions.find_each do |subscription|
      expect(NotificationQuestionSubscribersMailer).to receive(:notify).with(subscription, answer).and_call_original
    end

    NotificationQuestionSubscribersJob.perform_now(answer)
  end
end
