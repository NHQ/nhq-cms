class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String
  field :url, :type => String
  mount_uploader :image, ImageUploader
  
  referenced_in :show
  referenced_in :workshop
  
  validates_presence_of :title
end
