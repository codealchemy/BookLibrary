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
end
