class RoomChannel < ApplicationCable::Channel
  # フロントエンドとバックエンドがつながったときに実行される
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # byebug
    message = Message.create!(content: data['message'],
                              user_id: current_user.id,
                              room_id: params['room_id'])
    # template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    template = ApplicationController.render_with_signed_in_user(message.user, partial: 'messages/message', locals: {message: message})
    # 他の人へ配信コマンド
    ActionCable.server.broadcast "room_channel",
                                  message: template,
                                  room_id: params['room_id']
  end
end