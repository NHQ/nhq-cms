class Show
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  disable_tags_index! # will disable index creation

  field :title
  field :description
  field :additional_info

  mount_uploader :image, ImageUploader

  embeds_many :credits
  embeds_many :flickrs
  embeds_many :videos

  references_many :reviews, :stored_as => :array, :default => []

  validates_presence_of :title
  validates_presence_of :description  
  
end