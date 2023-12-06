class Wildlife < ApplicationRecord
    has_many :sightings

    accepts_nested_attributes_for :sightings

    validates :common_name, uniqueness: true, presence: true
    validates :scientific_binomial, uniqueness: true, presence: true
end
