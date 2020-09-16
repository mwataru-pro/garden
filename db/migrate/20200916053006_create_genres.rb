class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name
      t.integer :valid_invalid_status, default: 0

      t.timestamps
    end
  end
end
