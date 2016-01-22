# Preview all emails at http://localhost:3000/rails/mailers/notification_question_owner_mailer
class NotificationQuestionSubscribersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_question_owner_mailer/notify
  def notify
    NotificationQuestionSubscribersMailer.notify
  end

end
