class PagesController < ApplicationController

  def map

    @markers = params[:markers]

  end
end
