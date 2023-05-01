class Api::V1::FramesController < ApplicationController

  def index
    frames = Frame.all.order(id: :asc).map { |u| u.attributes.merge(images: u.images.present? ? u.images.map{ |image| url_for(image) } : '') }
    render json: {
    messages: 'List Of All Frames',
    frames: ,
    success: true
    }, status: :ok
  end

  def create
    frame = Frame.new(frame_params.except(:images))
    images = params[:frame][:images]

    if images
      images.each do |image|
        frame.images.attach(image)
      end
    end

    if frame.save
      render json: {
        messages: 'Frame was successfully created',
        frame: ,
        success: true
      }, status: :ok
    else
      render json: {
        messages: frame.errors.full_messages.join(", ").to_s
      },status: :not_found
    end
  end

  private

  def frame_params
    params.require(:frame).permit(:price, :discount, images: [], types_of_frame: [], types_of_material: [], no_of_frames: [], color: [], frame_size: {})
  end
end