require "rails_helper"

RSpec.describe NotificationQuestionSubscribersMailer, type: :mailer do
  describe "notify" do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }
    let(:subscription) { create(:subscription, question: question) }
    let(:mail) { NotificationQuestionSubscribersMailer.notify(subscription, answer) }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify")
      expect(mail.to).to eq([subscription.user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(answer.body)
    end
  end

end
