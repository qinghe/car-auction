class CarFile < ActiveRecord::Base
  TYPES = {:license => 0, :frame_number => 1, :accident => 2, :attachment => 3}
  FILE_MAX_SIZE = 10.megabytes
  attr_accessible :uploaded, :car_id
  
  belongs_to :car  
  validates_attachment_presence :uploaded,
                                :message => I18n.t('general.case.uploaded.must_be_set')
  validates_attachment_size :uploaded,
                            :less_than => FILE_MAX_SIZE,
                            :message => "moze maksymalnie wynosic #{(FILE_MAX_SIZE/1.megabyte).round(2)} MB"
  has_attached_file :uploaded, :styles => { :medium => "480x640", :thumb => "90x120" }
  before_post_process :skip_file_other_than_image # file other than images

  def skip_file_other_than_image
    #%w(image/gif image/jpeg image/bmp image/png image/pjpeg).include?(uploaded_content_type)
    uploaded_content_type=~/image/
  end

  #scope :for_license, lambda { where(:file_type => TYPES[:license])}
  #scope :for_frame_number, lambda { where(:file_type => TYPES[:frame_number])}
  #scope :for_accident, lambda { where(:file_type => TYPES[:accident])}
  #scope :for_attachment, lambda { where(:file_type => TYPES[:attachment])}

  def name
    self.uploaded_file_name
  end
  
  def size
    self.uploaded_file_size
  end

  def to_jq_upload
    {
      "id"=>id,
      "name" => read_attribute(:uploaded_file_name),
      "size" => read_attribute(:uploaded_file_size),
      "thumb_url" => uploaded.url(:thumb),
      "url" => uploaded.url,
      "content_type" => uploaded_content_type,
   #   "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end
  
end

