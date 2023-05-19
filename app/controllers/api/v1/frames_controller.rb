class Api::V1::FramesController < ApplicationController
  before_action :doorkeeper_authorize!, only: [:create]
  def index
    frames = Frame.includes(images_attachments: :blob).order(id: :asc)
    if params[:frame_material].present?
      frames = frames.where(types_of_material: params[:frame_material])
    end
    if params[:frame_type].present?
      frames = frames.where(types_of_frame: params[:frame_type])
    end
    if params[:no_frames].present?
      frames = frames.where(no_of_frames: params[:no_frames])
    end
    if params[:start] && params[:end].present?
      range = [(params[:start]).to_i..(params[:end]).to_i]
      frames = frames.where(price: range)
    end
    frames = frames.map do |frame|
      frame.attributes.merge(images: frame.images_attachments.present? ? frame.images_attachments.map { |attachment| url_for(attachment.blob) } : '')
    end
    render json: {
      messages: 'List of All Frames',
      frames: frames,
      success: true
    }, status: :ok
  end
    
  def create
    frame = Frame.new(frame_params)
    frame.frame_size =  JSON.parse(params[:frame_size])
    frame.color = JSON.parse(params[:color])
  
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

  # def show_frame_by_material(params[:frame_material])
  #   frames = Frame.where(types_of_material: params[:frame_material]).includes(images_attachments: :blob).order(id: :asc).map do |u|
  #     u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
  #   end
  # end
  private

  def frame_params
    params.require(:frame).permit(:price, :discount , :types_of_frame, :no_of_frames,  :types_of_material, images: [])
  end

  
end
