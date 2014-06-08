class User < ActiveRecord::Base
  validates :name,     presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4, maximum: 20 }

  has_many :friendships_from_oneself, -> { where(approval: true) }, class_name: :FriendShip, foreign_key: :from_user_id, dependent: :destroy
  has_many :friendships_to_oneself,   -> { where(approval: true) }, class_name: :FriendShip, foreign_key: :to_user_id,   dependent: :destroy
  has_many :pending_friendships_from_oneself, -> { where(approval: false) }, class_name: :FriendShip, foreign_key: :from_user_id, dependent: :destroy
  has_many :pending_friendships_to_oneself,   -> { where(approval: false) }, class_name: :FriendShip, foreign_key: :to_user_id,   dependent: :destroy

  has_many :friends_from_oneself, through: :friendships_from_oneself, source: :to_user
  has_many :friends_to_oneself,   through: :friendships_to_oneself,   source: :from_user
  has_many :pending_friends_from_oneself, through: :pending_friendships_from_oneself, source: :to_user
  has_many :pending_friends_to_oneself,   through: :pending_friendships_to_oneself,   source: :from_user

  has_secure_password

  def friends
    self.friends_from_oneself + self.friends_to_oneself
  end

  def relation(user)
    return 'Friend' if friends.include?(user)
    return 'Send friend request' if self.pending_friends_from_oneself.include?(user)
    return 'Has been requested'  if self.pending_friends_to_oneself.include?(user)
    return 'Oneself' if self == user
    return 'Nothing'
  end

  def has_relation?(user)
    relation(user) != 'Nothing'
  end

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
