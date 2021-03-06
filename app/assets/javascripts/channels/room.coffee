document.addEventListener 'turbolinks:load', ->
  room_id = $('#messages').data('room_id')
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: room_id },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # alert data['message']
      if data['room_id'] is room_id
        $('#messages').append data['message']
        # Called when there's incoming data on the websocket for this channel

    speak: (message) ->
      @perform 'speak', message: message

    # $('button').click , '[data-behavior~=room_speaker]', (event) ->
    #   if event.keyCode is 13
    #     App.room.speak event.target.value
    #     event.target.value = ''
    #     event.preventDefault()

    $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
        if event.keyCode is 13
          App.room.speak event.target.value
          event.target.value = ''
          event.preventDefault()

    $(document).on 'click', '.chat_submit', ->
      App.room.speak $('[data-behavior~=room_speaker]').val()
      $('[data-behavior~=room_speaker]').val('')
      event.preventDefault()
