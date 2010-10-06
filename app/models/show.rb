class Show
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  field :additional_info

  mount_uploader :image, ImageUploader

  embeds_many :credits

  references_many :reviews

  validates_presence_of :title
  validates_presence_of :description
end