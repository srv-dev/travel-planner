class Hotel < ApplicationRecord

  belongs_to :destination, optional: true

  has_and_belongs_to_many :users

end
