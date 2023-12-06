class Wildlife < ApplicationRecord
    has_many :sightings

    validates :common_name, presence: true
    validates :scientific_binomial, presence: true
end
