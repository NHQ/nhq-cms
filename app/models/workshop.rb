class Workshop
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  
  disable_tags_index! # will disable index creation

  field :title
  field :description
  mount_uploader :image, ImageUploader

  references_many :reviews
  embeds_many :flickrs

  validates_presence_of :title
  validates_presence_of :description
end
