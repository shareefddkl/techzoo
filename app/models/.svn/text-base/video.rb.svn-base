class Video < ActiveRecord::Base
  belongs_to :course
  #validates :title, :presence => true
  has_attached_file :video
  #validates_attachment_presence :video
  before_destroy :delete_video_folder
  after_create :convert_video
  has_many :comments, :class_name => "CommentsVideo", :foreign_key => :video_id, :dependent => :destroy
  #  attr_accessor :video_file_name
  #  destroy_attached_files

  #  attr_accessor :video_file_name
  #turn off attachment_fu's auto file renaming
  #when you change the value of the filename field
  def rename_file
    true
  end

  #acts as state machine plugin
  acts_as_state_machine :initial => :pending
  state :pending
  state :converting
  state :converted, :enter => :set_new_filename
  state :error

  event :convert do
    transitions :from => :pending, :to => :converting
  end

  event :converted do
    transitions :from => :converting, :to => :converted
  end

  event :failure do
    transitions :from => :converting, :to => :error
  end

  # This method is called from the controller and takes care of the converting
  def convert
    if !['mp3', 'MP3', 'mp4', 'MP4','flv', 'FLV'].include?(video.path.split("?")[0].split('.').last)
      self.convert!
      success = system(convert_command)
      if success && $?.exitstatus == 0
        self.converted!
        #        set_new_filename
      else
        self.failure!
      end
    end
    generate_tumbnail
  end

  def generate_tumbnail
    command = <<-end_command
          ffmpeg  -itsoffset -4  -i "#{ video.path }" -vcodec mjpeg -vframes 1 -an -f rawvideo -s 150x150 #{ video.path.to_s.split('original').first }/tumbnail/1.jpg
    end_command

    logger.debug "Generating video tumbnail ...command: " + command
    Dir.mkdir("#{ video.path.to_s.split('original').first }/tumbnail")
    system(command)
  end

  def tumbnail
    tumb = video.path.to_s.split("/original").first+"/tumbnail/1.jpg"
    return  File.exists?(tumb) ? (video.url.to_s.split("/original").first+"/tumbnail/1.jpg") : "/videos/default_video_tumb.png"
  end

  protected

  def convert_command

    #construct new file extension
    flv =  "." + id.to_s + ".flv"

    #build the command to execute ffmpeg
    command = <<-end_command
          ffmpeg -i #{ video.path }  -ar 22050 -ab 32 -f flv -y #{ video.path + flv }

    end_command

    logger.debug "Converting video...command: " + command
    command
  end

  # This updates the stored filename with the new flash video file
  def set_new_filename
    update_attribute(:video_file_name, "#{video_file_name+"."+id.to_s}.flv")
    #    generate_tumbnail
  end

  def delete_video_folder
    v = Video.find(:first, :conditions => ["id =? ",self.id])
    if v
      v_path = v.video.path.to_s.split("/original").first
      if !v_path.to_s.blank? and File.exists?(v_path)
        FileUtils.rm_rf v_path
      end
    end
  end
  
  def convert_video
    self.convert
  end
end
