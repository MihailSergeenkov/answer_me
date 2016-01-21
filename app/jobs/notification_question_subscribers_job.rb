class NotificationQuestionSubscribersJob < ActiveJob::Base
  queue_as :default

  def perform(question)
    question.subscriptions.each do |subscription|
      NotificationQuestionSubscribersMailer.notify(subscription).deliver_later
    end
  end
end
