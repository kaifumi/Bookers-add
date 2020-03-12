class MessagesController < ApplicationController
  before_action do
    @room = Room.find(params[:room_id])
  end

  def index
    @messages = @room.messages

    if @messages.length > 10
      @over_ten = true1
      # pluckメソッドで指定したカラムの配列を返す
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @messages = @room.messages
    end

    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end

    @messages = @messages.order(:created_at)
    @message = @room.messages.new
  end

  def create
    byebug
    @message = @room.messages.build(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render 'index'
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :user_id, :room_id)
    end
end
