class CreatePosters < ActiveRecord::Migration[7.0]
  def change
    create_table :posters do |t|
      t.integer :posterid
      t.text :description
      t.integer :price
      t.text :poster_size
      t.text :poster_type

      t.timestamps
    end
  end
end
