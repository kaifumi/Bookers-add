// room_id = $("#messages").data("room_id");
// App.room = App.cable.subscriptions.create(
//   { channel: "RoomChannel", room_id: room_id },
//   {
//     connected: function() {
//       console.log("connected");
//       // Called when the subscription is ready for use on the server
//     },

//     disconnected: function() {
//       // Called when the subscription has been terminated by the server
//     },

//     received: function(message) {
//       const messages = document.getElementById("messages");
//       messages.innerHTML += message;
//       // Called when there's incoming data on the websocket for this channel
//     },

//     // room_channelのspeakアクションとつながっている
//     speak: function(content) {
//       return this.perform("speak", { message: content });
//     }
//   }
// );

document.addEventListener("DOMContentLoaded", function() {
  const input = document.getElementById("chat-input");
  const button = document.getElementById("button");
  button.addEventListener("click", function() {
    content = input.value;
    App.room.speak(content);
    input.value = "";
  });
});
