class User
    include Mongoid::Document
    include Mongoid::Timestamps
    require 'bcrypt'
  
    field :email, type: String
    field :password_digest, type: String
  
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
  
    # Method to authenticate user
    def authenticate(password)
        BCrypt::Password.new(password_digest) == password
    end
end  