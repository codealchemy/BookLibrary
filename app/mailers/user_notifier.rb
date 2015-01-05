class UserNotifier < ActionMailer::Base
  include SendGrid
  default from: "from@example.com"

  def send_signup_email(user)
    @user = user
    mail( to: @user.email,
          subject: 'Your account is ready to go!' 
      )
  end

  def send_overdue_email(user)
    @user = user
    mail( to: @user.email,
          subject: 'You have an overdue book'
      )
  end
end
