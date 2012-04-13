var Chat = {}

jQuery(document).ready(function() {
  Chat.thisUser = thisUser;
  Chat.authenticityToken = jQuery("#authenticity-token").val();
  Chat.loadInitialData()
});

Chat.loadInitialData = function() {
  jQuery.noSpinner = true;

  jQuery.post('/chat/initial_data.json',
              { authenticity_token: Chat.authenticityToken },
              function(response){ Chat.processResponse(response);}, 'json');

  jQuery.noSpinner = false;
}

Chat.getUpdates = function() {
  Chat.clearTimeout();
  jQuery.noSpinner = true;

  jQuery.post('/chat/updates.json',
              { authenticity_token: Chat.authenticityToken },
              function(response){ Chat.processResponse(response); Chat.resetTimeout(); }, 'json');

  jQuery.noSpinner = false;
}

Chat.sendMessage = function(message) {
  jQuery.noSpinner = true;

  jQuery.post('/chat.json',
              { authenticity_token: Chat.authenticityToken,
                reciever_id: message.reciever.id,
                text: message.text },
              function(response){ Chat.processResponse(response); }, 'json');

  jQuery.noSpinner = false;
}

Chat.processResponse = function(response) {
  Chat.updateMessages(response.messages);
  Chat.updateUsers(response.users);
}

Chat.updateUsers = function(users) {
  for(var i=0; i<users.length; i++) {
    var u = users[i];
    user = Users.find(u.id)
    if(user)
      user.update(u);
    else
      user = Users.create(u);

    user.updateStatus();
  }
}

Chat.updateMessages = function(messages) {
  for(var i=0; i<messages.length; i++) {
    var sender = Users.find(messages[i].senderId) || {id: messages[i].senderId, name: messages[i].senderName};
    var reciever = Users.find(messages[i].recieverId) || {id: messages[i].recieverId, name: messages[i].recieverName};

    var friend = Chat.thisUser.id == sender.id ? reciever : sender;

    var message = Messages.create(messages[i].text, sender, reciever);

    var widget = Widgets.find(friend.id) || Widgets.create(friend.id, friend.name);

    widget.append(message);
  }
}

Chat.newMessage = function(messageText, senderName, senderId, recieverName, recieverId) {
  var sender = Users.find(senderId) || {id: senderId, name: senderName};
  var reciever = Users.find(recieverId) || {id: recieverId, name: recieverName};

  var friend = Chat.thisUser.id == sender.id ? reciever : sender;

  var message = Messages.create(messageText, sender, reciever);

  var widget = Widgets.find(friend.id) || Widgets.create(friend.id, friend.name);

  widget.append(message);
  widget.show();

  return widget;
}
