class Event
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  field :title
  field :description
  validates_presence_of :title
end
