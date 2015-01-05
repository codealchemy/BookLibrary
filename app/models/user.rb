class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def make_admin
    update_attribute(:admin, true)
  end

  def remove_admin
    update_attribute(:admin, false)
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver
  end

  def send_overdue_email
    UserNotifier.send_overdue_email(self).deliver
  end

  def name
    if first_name && last_name
      first_name + " " + last_name
    elsif last_name
      first_name
    elsif last_name
      last_name
    else
      "No name"
    end
  end
end
