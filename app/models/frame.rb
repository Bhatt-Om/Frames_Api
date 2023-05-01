class Frame < ApplicationRecord
  has_many_attached :images
  serialize :types_of_frame, Array
  serialize :types_of_material, JSON
  serialize :no_of_frames, Array
  serialize :color, Array
  serialize :frame_size, JSON
end
