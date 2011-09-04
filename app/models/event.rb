class Event
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title
  field :description
  field :event_type
  field :event_duration
  field :ticket_url
  field :ticket_price
  slug  :title

  disable_tags_index! # will disable index creation

  mount_uploader :image, ImageUploader
    
  embeds_many :showdates
  embeds_many :flickrs
  embeds_many :videos

  # references_many :venues, :stored_as => :array, :inverse_of => :event
  has_and_belongs_to_many :venues
  
  validates_presence_of :title
  validates_presence_of :description
  
  def map_string
    [self.street, self.city, self.state, self.zip].join(" ").split(' ').join("+")
  end
  
end
