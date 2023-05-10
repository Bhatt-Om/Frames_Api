class Frame < ApplicationRecord
  has_many_attached :images, dependent: :purge
  serialize :frame_size, Hash
  serialize :color, Array
end
