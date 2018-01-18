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

  def fetch_itinerary_details
    @itinerary_details = ItineraryDetail.where(itinerary_id: 12)
  end

  # def fetch_itinerary_places
  #   @place = Post.find(Like.includes(:post).where(posts: {place_name: place_name_params}).group(:post_id).order('count(post_id) desc').limit(1).pluck(:post_id))
  #   @place = Post.find_by(place_name: place_name_params) if @place.empty?
  # end
  def fetch_itinerary_places
    @places = []
    place_name_params.each do | place_name |
      postId = (Like.includes(:post).where(posts: {place_name: place_name}).group(:post_id).order('count(post_id) desc').first).try(:post_id)
      if postId.nil?
        place = Post.find_by(place_name: place_name)
      else
        place = Post.find(postId)
      end
      @places << place
    end
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

  # def place_name_params
  #   params.require(:place_name)
  # end
  def place_name_params
    params.require(:itineraries)
  end
end
