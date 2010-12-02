class Workshop
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  disable_tags_index! # will disable index creation

  field :title
  field :description
  slug :title
  mount_uploader :image, ImageUploader

  references_many :reviews, :stored_as => :array, :default => []
  
  embeds_many :flickrs
  embeds_many :videos

  validates_presence_of :title
  validates_presence_of :description
end
