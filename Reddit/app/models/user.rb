class User < ApplicationRecord

  validates :username, :session_token, :password_digest, presence: true
  validates :password_digest, :username, uniqueness: true
  validates :password, length: { minimum: 1, allow_nil: true }
  
  after_initialize :ensure_session_token

  attr_reader :password

  has_many :subs,
    foreign_key: :user_id,
    class_name: :Sub

  has_many :posts
  has_many :comments,
    foreign_key: :author_id,
    class_name: :Comment

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

end
