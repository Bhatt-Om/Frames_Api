class Api::V1::PostersController < ApplicationController
  
  def index
    posters = Poster.includes(image_attachment: :blob).order(id: :asc)

    if params[:type].present?
      posters = posters.where(poster_type: params[:type])
    end
    if params[:size].present?
      posters = posters.where(poster_size: params[:size])
    end
    if params[:start] && params[:end].present?
      range = [(params[:start]).to_i..(params[:end]).to_i]
      posters = posters.where(price: range)
    end
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

  def destroy
    poster = Poster.find_by(params[:id])
    poster.destroy
    render json: {
      messages: 'Poster was successfully Deleted',
      success: true
    }, status: :ok
  end
  private

  def poster_params
    params.require(:poster).permit(:posterid, :description, :price, :poster_type, :poster_size, :image)
  end
end