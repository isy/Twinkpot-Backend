class Api::ItinerariesController < ApiController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user_from_token!
  skip_before_action :verify_authenticity_token, only: %i(post_itineraries post_itinerary_details)

  def fetch_itineraries
    @itineraries = Itinerary.where(user_id: current_user.id).order('updated_at DESC')
  end

  def post_itineraries
    @itinerary = Itinerary.new(itinerary_params)

    if @itinerary.save
      render :create, status: :created
    else
      render json: @itinerary.errors, status: :unprocessable_entity
    end
  end

  def post_itinerary_details
    @itinerary = Itinerary.find(itinerary_id_params)
    @itinerary.itinerary_details.create(postdata_params)
  end

  private
  def itinerary_params
    params.require(:itinerary).permit(:itinerary_name).merge(user_id: current_user.id)
  end

  def itinerary_id_params
    params.require(:itinerary_details).require(:itinerary_id)
  end

  def postdata_params
    params.require(:itinerary_details).require(:post_data).permit(:place_name, :latitude, :longitude)
  end
end
