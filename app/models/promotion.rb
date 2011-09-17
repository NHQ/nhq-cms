class Promotion
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :body

  mount_uploader :image, ImageUploader
  
  embeds_many :videos
end