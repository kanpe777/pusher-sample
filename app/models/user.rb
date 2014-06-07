class User < ActiveRecord::Base
  validates :name,     presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4, maximum: 20 }
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
