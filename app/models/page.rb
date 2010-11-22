class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title
  field :hide_title, :type => Boolean
  field :body
  slug  :title
  
  embeds_many :flickrs
  embeds_many :videos

  validates_presence_of :title
  validates_presence_of :body
end