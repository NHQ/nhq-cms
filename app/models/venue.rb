class Venue
  include Mongoid::Document
  include Mongoid::Slug

  # referenced_in :event
  has_and_belongs_to_many :events
  
  field :venue_name, :type => String
  field :street, :type => String
  field :city, :type => String
  field :state, :type => String
  field :zip, :type => String
  field :phone, :type => String
  slug  :venue_name
  
  def map_string
    [self.street, self.city, self.state, self.zip].join(" ").split(' ').join("+")
  end
    
  validates_presence_of :venue_name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

end
