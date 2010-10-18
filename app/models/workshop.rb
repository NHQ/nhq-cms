class Workshop
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  mount_uploader :image, ImageUploader

  references_many :reviews
  embeds_many :flickrs

  validates_presence_of :title
  validates_presence_of :description
end
