class DestinationsController < ApplicationController

  def new
  end

  def create
    dest = params[:dest].split(', ')
    @dest = dest.first + ',' + dest.last

    if Destination.where(name: @dest).count == 1
      redirect_to user_path(@current_user.id)
      return
    end

    @img_url_ph = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&key=AIzaSyCuH_vm3pwVq6CoiDR1ZPM67DucLJh8hWg&photoreference="

    dest_obj = create_destination

    create_hotels dest_obj
    create_attractions dest_obj
    create_activities dest_obj

    @current_user.destinations  << dest_obj unless @current_user.destinations.include?(dest_obj)

    redirect_to user_path(@current_user.id)
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

    @attractions_cost = 0
    @current_user.attractions.each do |attraction|
      @attractions_cost += attraction.price if attraction.destination == @destination
    end

    # Code to pass hotel markers to Map
    @hotel_markers = []
    @current_user.hotels.each do |hotel|
      if hotel.destination == @destination && hotel.latitude && hotel.longitude
        @hotel_markers << {"title" => hotel.name, "lat" => hotel.latitude, "lng" => hotel.longitude}
      end
    end

    # Code to pass attractions markers to Map
    @attr_markers = []
    @current_user.attractions.each do |attraction|
      if attraction.destination == @destination && attraction.latitude && attraction.longitude
        @attr_markers << {"title" => attraction.name, "lat" => attraction.latitude, "lng" => attraction.longitude, "image" =>attraction.image }
      end
    end
  end

  def edit
    destination = Destination.find params[:id]

    @current_user.destinations  << destination unless @current_user.destinations.include?(destination)

    redirect_to user_path(@current_user.id)
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
      price = rand(60..200)

      attraction_obj = Attraction.create! name: name, image: attraction_img_url, address: address, latitude: latitude, longitude: longitude, price: price

      dest_obj.attractions << attraction_obj
    end
  end

  def create_activities dest_obj

    activities = [
      {name: 'Paragliding', image: '/assets/paragliding.jpeg', price: 100},
      {name: 'Parasailing', image: '/assets/parasailing.jpeg', price: 90},
      {name: 'Scuba diving', image: '/assets/scuba-diving.jpeg', price: 200},
      {name: 'River rafting', image: '/assets/river-rafting.jpeg', price: 120},
      {name: 'Sky diving', image: '/assets/skydiving.jpeg', price: 500},
      {name: 'Quad bike', image: '/assets/quad-bike.jpeg', price: 110}
    ]

    activities.each do |activity|

      activity_obj = Activity.create! name: activity[:name], image: activity[:image], price: activity[:price]

      dest_obj.activities << activity_obj

    end
  end

end
