class User < ApplicationRecord

    validates :username, presence: true, length: { minimum: 3, maximum: 64 }
    validates :password, presence: true, length: { minimum: 8, maximum: 64 }
    validates :email, presence: true
    validates_uniqueness_of :username, :email

    has_many :sessions
    has_many :tweets

end
