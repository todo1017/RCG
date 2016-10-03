class User < ActiveRecord::Base

  belongs_to :owner
  has_many :owner_users
  has_many :user_geographies
  has_many :user_buildings

  validates_uniqueness_of :email

  has_secure_password
  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
