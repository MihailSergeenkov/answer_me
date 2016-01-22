class NotificationQuestionSubscribersMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_question_owner_mailer.notify.subject
  #
  def notify(subscription, answer)
    @answer = answer

    mail to: subscription.user.email
  end
end
