class CreateWildlives < ActiveRecord::Migration[7.1]
  def change
    create_table :wildlives do |t|
      t.string :common_name
      t.string :scientific_binomial

      t.timestamps
    end
  end
end
