class Workshop
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  mount_uploader :image, ImageUploader

  references_many :reviews
  references_many :flickrs, :stored_as => :array, :inverse_of => :workshops

  validates_presence_of :title
  validates_presence_of :description
end
