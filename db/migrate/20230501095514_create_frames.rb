class CreateFrames < ActiveRecord::Migration[7.0]
  def change
    create_table :frames do |t|
      t.text :types_of_frame
      t.text :types_of_material
      t.text :no_of_frames
      t.text :color
      t.text :frame_size
      t.string :discount
      t.string :price
      
      t.timestamps
    end
  end
end
