class Sighting < ApplicationRecord
    belongs_to :wildlife
    validates :date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" }
end
