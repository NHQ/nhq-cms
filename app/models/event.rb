class Event
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  field :event_type
  field :event_duration

  mount_uploader :image, ImageUploader
    
  embeds_many :showdates
  embeds_many :flickrs

  references_many :venues, :stored_as => :array, :default => []
  
  validates_presence_of :title
  validates_presence_of :description
  
  def map_string
    [self.street, self.city, self.state, self.zip].join(" ").split(' ').join("+")
  end
  
end
