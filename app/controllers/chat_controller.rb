class ChatController < ApplicationController
skip_before_filter :is_loggedin?, :only => [:index]
  def index
   # session[:juggernaut_channels] = ["chat_channel"]
  end

  def send_data
    render :juggernaut do |page|
      page.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
    end
    render :nothing => true
  end
 def initial_data
    updates_hash = {:messages => {}}
    updates_hash[:messages] = current_user.chats.collect(&:json_data)
    updates_hash[:users] = current_user.friends.collect(&:json_data)

    respond_to do |format|
      format.json {render :json => updates_hash.to_json}
    end
  end

def create
    reciever = User.find(params[:reciever_id])
    current_user.sent_chats.new(:text => params[:text], :reciever_id => params[:reciever_id]).save
    if !reciever.is_online?
      message = Message.new(:subject => "Offline chat message from "+current_user.display_name, :body => params[:text], :user_id => current_user.id, :user_status => "sent", :message_type => "sent")
      message.to_address(current_user, params[:reciever_id])
      message.save
    end
    
    if reciever.is_online_on_web?
      messages = reciever.read_chats
      
      render :juggernaut => {:type => :send_to_channels, :channels => ["user-#{params[:reciever_id]}"]} do |page|
        for message in messages
          Juggernaut.send_to_channels_without_sign(message.to_json, ["iphone-user-#{params[:reciever_id]}"])
          page.call("Chat.newMessage", message.text, message.sender.name, message.sender.id, message.reciever.name, message.reciever.id)
        end
      end
    end

    render :nothing => true
  end
end
