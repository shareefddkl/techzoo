class MessagesController < ApplicationController

  #GET messages/new
  def new
    @message = current_user.sent_messages.build
  end

  #POST messages/
  def create
    @message = current_user.sent_messages.build(params[:message])
    if @message.save
      flash[:notice] = "Your's Message succussfully sent."
      redirect_to messages_path
    else
      render :action => :new
    end
  end

  #GET messages/
  def index
    #@users = User.find(:all, :joins => "left join messages on messages.user_id = #{current_user.id} or messages.receiver_id = #{current_user.id}", :conditions => ["(users.id = messages.receiver_id or messages.id = #{current_user.id}) and (users.id != #{current_user.id})"], :group => "users.id")
    @users = User.find(:all, :joins => "left join messages on messages.user_id = #{current_user.id} or messages.receiver_id = #{current_user.id}", :conditions => ["(users.id = messages.user_id or messages.user_id = #{current_user.id}) and (users.id != #{current_user.id})"], :group => "users.id")
    @messages = []
    @users.each do |user|
      @messages << Message.find(:first, :conditions => ["(messages.user_id = #{current_user.id} and messages.receiver_id = #{user.id}) or (messages.receiver_id = #{current_user.id} and messages.user_id = #{user.id} )"], :order => ["created_at Desc"])
    end
    #@messages = Message.find(:all, :conditions => ["(messages.user_id = #{current_user.id} and receiver_id = #{params[:receiver_id]}) or (messages.receiver_id = #{current_user.id} and uesr_id = #{params[:user_id]})"])
  end

  #GET messages/:id/conversation
  def conversation
    @user = User.find(params[:id])
    @messages = Message.paginate :conditions => ["(messages.user_id = #{current_user.id} and messages.receiver_id = #{params[:id]}) or (messages.receiver_id = #{current_user.id} and messages.user_id = #{params[:id]})"], :page => params[:page], :per_page => 5
  end
  

  #POST messages/:id/reply
  def reply
    #@original = current_user.received_messages.find(params[:id])
    #@message = current_user.sent_messages.build(:user_id => current_user.id)
    #render :action => "new"
    @message = Message.new(params[:message].merge({:receiver_id => params[:id], :user_id => current_user.id, :receiver_status => "unread", :user_status => "sent"}))
    #@reply = @message.users.new(params[:reply])
    if @message.save
      flash[:notice] = "Your's Reply Message succussfully sent."
      redirect_to conversation_message_path(params[:id])
    else
      flash[:error] = "Your's Reply Message failed."
    end
  end

  #DELETE messages/:id
  def destroy
    deleted = false
    @message = Message.find(params[:id])
    if @message.user_id == current_user.id
      if @message.receiver_status == 'deleted'
        deleted = @message.destroy
      else
        deleted = @message.update_attribute(:user_status, "deleted")
      end
    elsif @message.receiver_id == current_user.id
      if @message.user_status == 'deleted'
        deleted = @message.destroy
      else
        deleted = @message.update_attribute(:receiver_status,  "deleted")
      end
    end
    render :update do |page|
      if deleted
        page.replace 'message_'+params[:id]
      else
        page.alert('Permission denie')
      end
    end
  end
end
