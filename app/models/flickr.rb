class Flickr
  include Mongoid::Document

  embedded_in :show, :inverse_of => :flickrs
  embedded_in :workshop, :inverse_of => :flickrs
  embedded_in :event, :inverse_of => :flickrs

end