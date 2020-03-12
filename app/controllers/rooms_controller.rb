class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms =Room.all
  end

  def create
    # .between(min,max)でmin~maxの範囲内にあればtrueを返す
    if Room.between(params[:sender_id],params[:recipient_id]).present?
      @room = Room.between(params[:sender_id],params[:recipient_id]).first
    else
      @room = Room.create!(room_params)
    end
    redirect_to room_messages_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.recent.limit(10).reverse
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to request.referrer
  end

  private
    def room_params
      params.permit(:sender_id, :recipient_id)
    end 
end
