class Video
  include Mongoid::Document

  field :code
  
  embedded_in :show, :inverse_of => :videos
  embedded_in :workshop, :inverse_of => :videos
  embedded_in :event, :inverse_of => :videos

  validates_presence_of :code
  
end