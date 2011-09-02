class Show
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  include Mongoid::Slug

  disable_tags_index! # will disable index creation

  field :title
  field :description
  field :additional_info
  slug  :title

  mount_uploader :image, ImageUploader

  # references_many :reviews, :stored_as => :array, :default => []
  references_many :reviews


  embeds_many :credits
  embeds_many :flickrs
  embeds_many :videos

  validates_presence_of :title
  validates_presence_of :description  
  
end