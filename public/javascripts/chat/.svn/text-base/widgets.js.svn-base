var Widgets = {}
var Widget = {}

Widget.selector = function() {
  return "#chat-widgets-container #" + this.id;
}

Widget.show = function() {
  jQuery(widget.selector()).removeClass("hidden");
  this.scrollToBottom();

  return this;
}

Widget.hide = function() {
  jQuery(widget.selector()).addClass("hidden");

  return this;
}

Widget.highlight = function() {
  jQuery(this.selector()).addClass("highlight");

  return this;
}

Widget.unHighlight = function() {
  jQuery(this.selector()).removeClass("highlight");

  return this;
}

Widget.focus = function() {
  jQuery(this.selector()).removeClass("minimized");
  jQuery(this.selector() + " .form-container textarea").focus();

  return this;
}

Widget.append = function(message) {
  if(message.text.replace(/[\s\n]/g, "").length > 0) {
    jQuery(this.selector() + " .messages").append(message.toHtml(this.lastSenderId));
    this.lastSenderId = message.sender.id;

    this.scrollToBottom();
  }

  return this;
}

Widget.scrollToBottom = function() {
  var messageContainer = jQuery(this.selector() + " .messages");
  var scrollTop = messageContainer.scrollTop();
  do {
    scrollTop = scrollTop + 1000;
    messageContainer.scrollTop(scrollTop);
  } while(messageContainer.scrollTop() >= scrollTop)

  return this;
}

Widget.registerEvents = function() {
  widget = this;

  jQuery(widget.selector() + " .widget-header").click(function() {
    jQuery(widget.selector()).toggleClass("minimized");
    jQuery(widget.selector()).removeClass("highlight");
  });

  jQuery(widget.selector() + " .widget-close").click(function() {
    widget.hide();
  });

  jQuery(widget.selector() + " .form-container textarea").keypress(function(event) {
    if(!event.shiftKey) {
      if(event.keyCode == 13) {
        var sender = {id: Chat.thisUser.id, name: "Me"};
        var reciever = Users.find(widget.friendId);
        var message = Messages.create(jQuery(this).val(), sender, reciever);

        Chat.sendMessage(message)
        widget.append(message);
        jQuery(this).val("");
        return false;
      }
    }
  });

  jQuery(widget.selector() + " .form-container textarea").focus(function(event) {
    jQuery(widget.selector()).removeClass("highlight");
  });

  return widget;
}

Widgets.find = function(i) {
  if(this.objects == undefined)
    this.objects = {};

  return (this.objects[i] || false);
}

Widgets.create = function(friendId, friendName) {
  if(Widgets.find(friendId))
    return false;

  var widget = jQuery.extend({ id: "chat-widget-" + friendId, friendId: friendId, friendName: friendName }, Widget);
  this.objects[friendId] = widget;

  jQuery("#chat-widgets-container").append(jQuery("#widgetTemplate").tmpl(widget));

  widget.registerEvents();

  return widget;
}
