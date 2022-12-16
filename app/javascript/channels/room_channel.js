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
    return this.perform('speak', {chat: chat});
  }
});

window.addEventListener("click", function(e) {
  // enterが押された時
  if (e.keyCode === 13) {
    // speakアクションを発火
    appRoom.speak(e.target.value);
    // テキストボックスに入力した文字列を取得。
    e.target.value = '';
    // 
    e.preventDefault();
  }
})