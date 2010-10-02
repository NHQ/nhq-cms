class Workshop
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  mount_uploader :image, ImageUploader

  references_many :reviews

  validates_presence_of :title
end
