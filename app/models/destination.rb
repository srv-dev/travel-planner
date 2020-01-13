class Destination < ApplicationRecord

  has_and_belongs_to_many :users

  has_many :attractions
  has_many :hotels
  has_many :activities

end
