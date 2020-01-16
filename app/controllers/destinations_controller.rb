class DestinationsController < ApplicationController

  def new
  end

  def create
    dest = params[:dest].split(', ')
    @dest = dest.first + ',' + dest.last

    @img_url_ph = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&key=AIzaSyCuH_vm3pwVq6CoiDR1ZPM67DucLJh8hWg&photoreference="

    dest_obj = create_destination

    create_hotels dest_obj
    create_attractions dest_obj

    # redirect_to
  end

  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find params[:id]

    @hotels_cost = 0
    @current_user.hotels.each do |hotel|
      @hotels_cost += hotel.price if hotel.destination == @destination
    end

    @activities_cost = 0
    @current_user.activities.each do |activity|
      @activities_cost += activity.price if activity.destination == @destination
    end


    # Code to pass destinations array to Map
    @hotel_markers = []
    @current_user.hotels.each do |hotel|
      if hotel.destination == @destination && hotel.latitude && hotel.longitude
        @hotel_markers << {"title" => hotel.name, "lat" => hotel.latitude, "lng" => hotel.longitude}
      end
    end

    # Code to pass destinations array to Map
    @attr_markers = []
    @current_user.attractions.each do |attraction|
      if attraction.destination == @destination && attraction.latitude && attraction.longitude
        @attr_markers << {"title" => attraction.name, "lat" => attraction.latitude, "lng" => attraction.longitude}
      end
    end


  end

  def edit
    destination = Destination.find params[:id]
    # user = User.find_by params[:id]

    @current_user.destinations  << destination unless @current_user.destinations.include?(destination)

    redirect_to user_path(@current_user.id)
  end

  def update
  end

  def destroy
  end

  def create_destination

    dest_info_url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?inputtype=textquery&fields=formatted_address,photos/photo_reference,name,geometry/location&key=AIzaSyCuH_vm3pwVq6CoiDR1ZPM67DucLJh8hWg&input="

    response = HTTParty.get(dest_info_url+@dest)
    hash = JSON.parse response.body

    dest_img_url = @img_url_ph + hash["candidates"][0]["photos"][0]["photo_reference"]

    latitude = hash["candidates"][0]["geometry"]["location"]["lat"]
    longitude = hash["candidates"][0]["geometry"]["location"]["lng"]
    address = hash["candidates"][0]["formatted_address"]

    Destination.create! name: @dest, image: dest_img_url, address: address, latitude: latitude, longitude: longitude

  end

  def create_hotels dest_obj

    hotel_info_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyCuH_vm3pwVq6CoiDR1ZPM67DucLJh8hWg&query=hotels%20in%20"

    response = HTTParty.get(hotel_info_url+@dest)
    hash = JSON.parse response.body

    hash["results"].each do |result|

      name = result["name"]
      hotel_img_url = @img_url_ph + result["photos"][0]["photo_reference"]
      address = result["formatted_address"]
      latitude = result["geometry"]["location"]["lat"]
      longitude = result["geometry"]["location"]["lng"]
      price = rand(60..300)

      hotel_obj = Hotel.create! name: name, image: hotel_img_url, address: address, latitude: latitude, longitude: longitude, price: price

      dest_obj.hotels << hotel_obj
    end
  end

  def create_attractions dest_obj

    attraction_info_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyCuH_vm3pwVq6CoiDR1ZPM67DucLJh8hWg&query=places%20of%20interest%20in%20"

    response = HTTParty.get(attraction_info_url+@dest)
    hash = JSON.parse response.body

    hash["results"].each do |result|

      name = result["name"]
      attraction_img_url = @img_url_ph + result["photos"][0]["photo_reference"]
      address = result["formatted_address"]
      latitude = result["geometry"]["location"]["lat"]
      longitude = result["geometry"]["location"]["lng"]

      attraction_obj = Attraction.create! name: name, image: attraction_img_url, address: address, latitude: latitude, longitude: longitude

      dest_obj.attractions << attraction_obj
    end
  end

end
