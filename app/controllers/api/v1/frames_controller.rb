class Api::V1::FramesController < ApplicationController
  # before_action :doorkeeper_authorize!, only: [:create]

  def index
    # frames = Frame.includes(:images).order(id: :asc).map { |u| u.attributes.merge(images: u.images.present? ? u.images.map{ |image| url_for(image) } : '') }
    if params[:frame_material].present?
      case params[:frame_material]
      when "Acrylic"
        frames = Frame.where(types_of_material: params[:frame_material]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      when "Wooden"
        frames = Frame.where(types_of_material: params[:frame_material]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      else
        frames = Frame.includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      end
    elsif params[:frame_type].present?
      case params[:frame_type]
      when "Table Mount"
        frames = Frame.where(types_of_frame: params[:frame_type]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      when "Both"
        frames = Frame.where(types_of_frame: params[:frame_type]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      when "Wall Mount"
        frames = Frame.where(types_of_frame: params[:frame_type]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      else
        frames = Frame.includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      end
    elsif params[:no_frmaes].present?
      case params[:no_frmaes]
      when "Multiple"
        frames = Frame.where(no_of_frames: params[:no_frmaes]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      when "Single"
        frames = Frame.where(no_of_frames: params[:no_frmaes]).includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      else
        frames = Frame.includes(images_attachments: :blob).order(id: :asc).map do |u|
          u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
        end
      end
    else
    frames = Frame.includes(images_attachments: :blob).order(id: :asc).map do |u|
      u.attributes.merge(images: u.images_attachments.present? ? u.images_attachments.map{ |attachment| url_for(attachment.blob) } : '')
    end
    end 
      render json: {
      messages: 'List Of All Frames',
      frames: ,
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
