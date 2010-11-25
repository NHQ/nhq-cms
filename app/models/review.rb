class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :description
  field :url
  mount_uploader :image, ImageUploader
  
  referenced_in :show
  referenced_in :workshop
  
  validates_presence_of :title
  validates_presence_of :description
end
