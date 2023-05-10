class Poster < ApplicationRecord
  has_one_attached :image, dependent: :purge
  serialize :poster_size, Hash
  serialize :poster_type, Array
end
