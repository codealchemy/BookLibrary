class UserNotifier < ActionMailer::Base
  include SendGrid
  default from: "from@example.com"

  def send_signup_email(user)
    @user = user
    mail( to: @user.email,
          subject: 'Thanks for signing up for my amazing app' 
        )
  end
end
