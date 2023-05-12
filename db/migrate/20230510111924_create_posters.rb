class CreatePosters < ActiveRecord::Migration[7.0]
  def change
    create_table :posters do |t|
      t.integer :posterid
      t.text :description
      t.integer :price
      t.string :poster_size
      t.string :poster_type

      t.timestamps
    end
  end
end
