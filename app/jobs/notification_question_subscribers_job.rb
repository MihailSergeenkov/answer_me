class NotificationQuestionSubscribersJob < ActiveJob::Base
  queue_as :default

  def perform(answer)
    all_subscriptions(answer).find_each do |subscription|
      NotificationQuestionSubscribersMailer.notify(subscription, answer).deliver_later
    end
  end

  private

  def all_subscriptions(answer)
    answer.question.subscriptions
  end
end
