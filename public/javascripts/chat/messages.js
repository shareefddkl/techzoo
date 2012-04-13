var Message = {}
var Messages = {}

Message.toHtml = function(lastSenderId) {
  if(this.sender.id == Chat.thisUser.id) {
    this.sender.name = "Me"
  }

  if(this.sender.id != lastSenderId)
    return jQuery("#messageTemplateWithSender").tmpl(this);
  else
    return jQuery("#messageTemplateWithoutSender").tmpl(this);
}

Messages.create = function(text, sender, reciever) {
  return jQuery.extend({ text: text, sender: sender, reciever: reciever}, Message);
}
