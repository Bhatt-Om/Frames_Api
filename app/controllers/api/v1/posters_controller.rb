class Api::V1::PostersController < ApplicationController

  def index
    posters = Poster.order(id: :asc)

    posters = posters.map do |poster|
      poster.attributes.merge(image: url_for(poster.image))
    end
    render json: {
      messages: 'List of All Posters',
      posters: posters,
      success: true
    }, status: :ok
  end

  def create
    poster = Poster.new(poster_params)
    if poster.save
      render json: {
      messages: 'Poster was successfully created',
      poster: ,
      success: true
    }, status: :ok
    else  
      render json: {
        messages: poster.errors.full_messages.join(', ').to_s
      }, status: :not_found
    end
  end

  private

  def poster_params
    params.require(:poster).permit(:posterid, :description, :price, :image, poster_size: {}, poster_type: [])
  end
end