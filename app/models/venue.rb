class Venue
  include Mongoid::Document
  
  referenced_in :event
  
  field :venue_name, :type => String
  field :street, :type => String
  field :city, :type => String
  field :state, :type => String
  field :zip, :type => String
  
  def map_string
    [self.street, self.city, self.state, self.zip].join(" ").split(' ').join("+")
  end
    
  validates_presence_of :venue_name

end
