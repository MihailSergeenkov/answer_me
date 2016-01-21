class NotificationQuestionSubscribersMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_question_owner_mailer.notify.subject
  #
  def notify(subscription)
    @question = subscription.question

    mail to: subscription.user.email
  end
end
