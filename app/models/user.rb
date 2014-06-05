class User < ActiveRecord::Base
  validates :name,     presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4, maximum: 20 }
end
