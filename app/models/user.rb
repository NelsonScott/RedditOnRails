class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :name, presence: true
  validates :session_token, presence: true
  validates :password_digest, presence: true

  has_many :subs,
           :class_name => "Sub",
           :foreign_key => :moderator_id,
           :primary_key => :id,
           :inverse_of => :moderator
  has_many :links, inverse_of: :user
  has_many :comments, inverse_of: :user
  has_many :user_votes, inverse_of: :user

  def password=(pw_string)
    self.password_digest = BCrypt::Password.create(pw_string)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end

