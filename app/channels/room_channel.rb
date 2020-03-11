class RoomChannel < ApplicationCable::Channel
  # フロントエンドとバックエンドがつながったときに実行される
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # binding.pry
    message = Message.create!(content: data['message'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    # 他の人へ配信コマンド
    ActionCable.server.broadcast "room_channel",template

    # message = Post.create!(content: data['message'], user_id: data['user_id'], chatroom_id: data['room_id'])
    # template = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: current_user }) # current_user変数にconnection.rbで取得したcurrent_userを設定
    # ActionCable.server.broadcast 'room_channel', message: template
  end
end