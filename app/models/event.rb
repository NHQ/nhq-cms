class Event
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  field :event_type
  field :venue_name
  field :street
  field :city
  field :state
  field :zip

  mount_uploader :image, ImageUploader
    
  embeds_many :showdates

  validates_presence_of :title
  
  def map_string
    [self.street, self.city, self.state, self.zip].join(" ").split(' ').join("+")
  end
  
end
