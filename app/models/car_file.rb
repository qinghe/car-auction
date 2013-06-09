class CarFile < ActiveRecord::Base
  TYPES = {:license => 0, :frame_number => 1, :accident => 2}
  FILE_MAX_SIZE = 10.megabytes
  belongs_to :car
  
  validates_attachment_presence :car_file,
                                :message => I18n.t('general.project.car_file.must_be_set')
  validates_attachment_size :car_file,
                            :less_than => FILE_MAX_SIZE,
                            :message => "moze maksymalnie wynosic #{(FILE_MAX_SIZE/1.megabyte).round(2)} MB"
  has_attached_file :car_file


  scope :for_license, lambda { where(:type => TYPES[:license])}
  scope :for_frame_number, lambda { where(:type => TYPES[:frame_number])}
  scope :for_accident, lambda { where(:type => TYPES[:accident])}
  
  def name
    self.car_file_file_name
  end
  
  def size
    self.car_file_file_size
  end
end

