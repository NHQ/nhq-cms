class Video
  include Mongoid::Document

  field :code
  
  embedded_in :show
  embedded_in :workshop
  embedded_in :event
  embedded_in :promotion

  validates_presence_of :code
  
end