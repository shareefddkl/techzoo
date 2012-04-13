module ApplicationHelper
  # Display validation error with red color
 def link_to_chat(title, user, options={})
    link_to_function title, "(Widgets.find(#{user.id}) || Widgets.create(#{user.id}, '#{user.display_name}')).show().focus();", options
  end

  def get_chat_link(user, link_title=I18n.t('helper.link_title'), link_options={})
    if current_user and user.id != current_user.id and user.is_online?
      link_to_chat(link_title, user, link_options)
    end
  end
  def user_online_status_image(user)
    if user.is_online?
      return image_tag('icons/user_online.gif', :title => "#{user.display_name} #{I18n('helper.is_online')}", :style => "border:0 none;")
    else
      return image_tag('icons/user_offline.gif', :title => "#{user.display_name}  #{I18n.t('helper.is_offline')}", :style => "border:0 none;")
    end
  end

  def validation_error(message)
    if message.class.to_s == "Array"
      message = message.first
    end
    return !message.to_s.blank? ? ("<div class='form_error'>"+message.to_s+"</div>").html_safe : ""
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
end
