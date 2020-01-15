class Destination < ApplicationRecord

  has_and_belongs_to_many :users

  has_many :attractions
  has_many :hotels
  has_many :activities

  # Tell geocoder where to look to get the human-readable address string
  # which will be used to derive lat/long coordinates
  geocoded_by :address

  # Tell geocoder to actually turn the above address into a latitude and longitude
  # (by doing a lookup in a remote API) anytime you create or update a Destination item
  after_validation :geocode


end
