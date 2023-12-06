class Sighting < ApplicationRecord
    belongs_to :wildlife

    validates :wildlife_id, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true
    validates :date, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" } 
end
