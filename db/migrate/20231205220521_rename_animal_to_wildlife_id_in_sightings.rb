class RenameAnimalToWildlifeIdInSightings < ActiveRecord::Migration[7.1]
  def change
    rename_column :sightings, :animal_id, :wildlife_id
  end
end
