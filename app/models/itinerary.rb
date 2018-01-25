class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :itinerary_details, dependent: :destroy
end
