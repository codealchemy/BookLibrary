class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def make_admin
    update(admin: true)
  end

  def remove_admin
    update(admin: false)
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver
  end

  def send_overdue_email
    UserNotifier.send_overdue_email(self).deliver
  end

  def name
    name = [first_name, last_name].map(&:to_s).join(" ").strip
    name.empty? ? "No name" : name
  end
end
