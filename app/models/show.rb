class Show
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description

  mount_uploader :image, ImageUploader

  validates_presence_of :title
end