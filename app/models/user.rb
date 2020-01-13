class User < ApplicationRecord

  has_secure_password

  validates :email, presence: true, uniqueness: true # validates email field is present
  validates :name, presence: true, length: {maximum: 50}

  has_and_belongs_to_many :destinations

  has_and_belongs_to_many :attractions
  has_and_belongs_to_many :hotels
  has_and_belongs_to_many :activities

end
