import consumer from "./consumer"

//
const appRoom = consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    return alert(data["chats"]);
  },

  speak: function(chat) {
    // speakアクションを動かすためにspeak関数を定義する
    // chatを引数としてe.target.valueをspeakアクションに渡す
    return this.perform("speak", {chat: chat});
  }
});

// window.addEventListener ('click', function(event) {
//   if(event.onclick === "#chat_btn"){
//   appRoom.speak; $(speaker_text).val();
//     event.target.value = '';
//     event.preventDefault();
// }
// })

// $(document).on ('click', '#chat_btn', function(e) {
//   // appRoom.speak(e.target.value);
//   //   e.target.value = '';
//   //   e.preventDefault();
//   console.log ("A");
// })

