class PagesController < ApplicationController
  def map
    @destinations = Destination.select(:name, :latitude, :longitude)
  end
end
