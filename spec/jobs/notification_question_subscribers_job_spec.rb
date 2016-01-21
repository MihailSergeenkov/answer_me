require 'rails_helper'

RSpec.describe NotificationQuestionSubscribersJob, type: :job do
  let(:question) { create(:question) }
  let(:subscription) { create(:subscription, question: question) }

  it 'sends notification for question subscribers' do
    expect(NotificationQuestionSubscribersMailer).to receive(:notify).with(subscription).and_call_original
    NotificationQuestionSubscribersJob.perform_now(question)
  end
end
