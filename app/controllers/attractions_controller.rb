class AttractionsController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def show
    @destination = Destination.find params[:id]
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
