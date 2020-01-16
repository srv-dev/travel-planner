class PagesController < ApplicationController

  require 'cgi'

  def map
    # @destinations = Destination.select(:name, :latitude, :longitude)
    @markers = params[:markers]
    # raise hell
  end
end
