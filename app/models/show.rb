class Show
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  field :title
  field :description
  field :additional_info

  embeds_many :credits
  accepts_nested_attributes_for :credits, :reject_if => lambda { |t| t['role'].nil? }, :allow_destroy => true

  mount_uploader :image, ImageUploader

  references_many :reviews

  validates_presence_of :title
end